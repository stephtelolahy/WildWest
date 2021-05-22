//
//  GAbilityMatcher.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public class GAbilityMatcher: AbilityMatcherProtocol {
    
    private let abilities: [String: GAbility]
    
    public init(_ abilities: [GAbility]) {
        self.abilities = abilities.toDictionary(with: { $0.name })
    }
    
    public func active(in state: StateProtocol) -> [GMove]? {
        let actor = state.hits.first?.player ?? state.turn
        return active(actor: actor, in: state)
    }
    
    public func triggered(on event: GEvent, in state: StateProtocol) -> [GMove]? {
        nil
    }
    
    public func effects(on move: GMove, in state: StateProtocol) -> [GEvent]? {
        let actor = state.players[move.actor]!
        
        guard var events = effects(on: move, actor: actor, in: state) else {
            return nil
        }
        
        // <RULE> discard immediately played hand card
        if case let .hand(card) = move.card,
           let cardObject = actor.hand.first(where: { $0.identifier == card }),
           cardObject.type == .brown {
            events.insert(.play(player: move.actor, card: card), at: 0)
        }
        // </RULE>
        
        return events
    }
}

private extension GAbilityMatcher {
    
    func active(actor identifier: String,
                in state: StateProtocol) -> [GMove]? {
        let actor = state.players[identifier]!
        let innerAbilities = abilities(applicableTo: actor)
        let innerMoves: [GMove] = innerAbilities.keys
            .compactMap { self.moves(ofType: .active, ability: $0, card: nil, actor: actor, in: state) }
            .flatMap { $0 }
        
        let playHandMoves: [GMove] = actor.hand.flatMap { card -> [GMove] in
            abilities(applicableTo: card, actor: actor).keys
                .compactMap { ability -> [GMove]? in
                    self.moves(ofType: .active, ability: ability, card: .hand(card.identifier), actor: actor, in: state)?
                        .filter { move -> Bool in
                            if let target = move.args[.target]?.first,
                               let targetObject = state.players[target],
                               self.isPlayer(targetObject, targetableBy: card) == false {
                                return false
                            }
                            
                            return true
                        }
                }
                .flatMap { $0 }
        }
        
        let reactionMoves: [GMove]
        if let hit = state.hits.first,
           hit.player == identifier {
            reactionMoves = hit.abilities
                .compactMap { self.moves(ofType: .active, ability: $0, card: nil, actor: actor, in: state) }
                .flatMap { $0 }
        } else {
            reactionMoves = []
        }
        
        return (innerMoves + playHandMoves + reactionMoves).notEmptyOrNil()
    }
    
    func triggered(on event: GEvent,
                   actor identifier: String,
                   in state: StateProtocol) -> [GMove]? {
        let actor = state.players[identifier]!
        let innerAbilities = abilities(applicableTo: actor)
        let innerMoves: [GMove] = innerAbilities.keys
            .compactMap { self.moves(ofType: .triggered, ability: $0, card: nil, actor: actor, in: state, event: event) }
            .flatMap { $0 }
        
        let inPlayMoves: [GMove] = actor.inPlay.flatMap { card -> [GMove] in
            card.abilities.keys
                .compactMap { self.moves(ofType: .triggered, ability: $0, card: .inPlay(card.identifier), actor: actor, in: state, event: event) }
                .flatMap { $0 }
        }
        
        return (innerMoves + inPlayMoves).notEmptyOrNil()
    }
    
    func moves(ofType abilityType: AbilityType,
               ability: String,
               card: PlayCard?,
               actor: PlayerProtocol,
               in state: StateProtocol,
               event: GEvent? = nil) -> [GMove]? {
        // find ability
        guard let abilityObject = abilities[ability] else {
            return nil
        }
        
        // verify ability type
        guard abilityObject.type == abilityType else {
            return nil
        }
        
        // verify requirements
        let ctx = PlayReqContext(ability: ability,
                                 actor: actor,
                                 state: state,
                                 event: event)
        guard let playArgs = match(abilityObject.canPlay, ctx: ctx) else {
            return nil
        }
        
        // build moves
        let moves: [GMove]
        if playArgs.isEmpty {
            moves = [GMove(ability, actor: actor.identifier, card: card)]
        } else {
            moves = playArgs.map { GMove(ability, actor: actor.identifier, card: card, args: $0) }
        }
        
        // <RULE> A move is applicable when it has effects>
        let effectiveMoves = moves.filter { effects(on: $0, actor: actor, in: state) != nil }
        // </RULE>
        return effectiveMoves
    }
    
    func effects(on move: GMove, actor: PlayerProtocol, in state: StateProtocol) -> [GEvent]? {
        // find ability
        guard let ability = abilities[move.ability] else {
            fatalError("Ability \(move.ability) not found")
        }
        
        let ctx = EffectContext(ability: move.ability,
                                actor: actor,
                                card: move.card,
                                args: move.args,
                                state: state)
        
        return apply(ability.onPlay, ctx: ctx)?
            .notEmptyOrNil()
    }
    
    func match(_ playReqs: [GPlayReq], ctx: PlayReqContext) -> [[PlayArg: [String]]]? {
        var playArgs: [[PlayArg: [String]]] = []
        guard playReqs.allSatisfy({ $0.match(ctx, args: &playArgs) }) else {
            return nil
        }
        return playArgs
    }
    
    func apply(_ effects: [GEffect], ctx: EffectContext) -> [GEvent]? {
        var result: [GEvent] = []
        for effect in effects {
            guard let events = effect.apply(ctx),
                  !events.isEmpty || effect.optional else {
                return nil
            }
            
            result.append(contentsOf: events)
        }
        return result
    }
}

private extension GAbilityMatcher {
    
    func abilities(applicableTo actor: PlayerProtocol) -> [String: Int] {
        var abilities = actor.abilities
        
        if actor.abilities["silentStartTurnOnPhase1"] != nil {
            abilities.removeValue(forKey: "startTurnOnPhase1")
        }
        
        return abilities
    }
    
    func abilities(applicableTo card: CardProtocol, actor: PlayerProtocol) -> [String: Int] {
        var abilities = card.abilities
        
        if actor.abilities["playBangAsMissed"] != nil,
           card.name == "bang" {
            abilities["missed"] = 0
        }
        
        if actor.abilities["playMissedAsBang"] != nil,
           card.name == "missed" {
            abilities["bang"] = 0
        }
        
        return abilities
    }
    
    func isPlayer(_ player: PlayerProtocol, targetableBy card: CardProtocol) -> Bool {
        if player.abilities["silentJail"] != nil,
           card.name == "jail" {
            return false
        }
        
        return true
    }
}

