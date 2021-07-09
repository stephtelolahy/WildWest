//
//  AbilityMatcher.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public protocol AbilityMatcherProtocol {
    func active(in state: StateProtocol) -> [GMove]?
    func triggered(on event: GEvent, in state: StateProtocol) -> [GMove]?
    func effects(on move: GMove, in state: StateProtocol) -> [GEvent]?
}

public class AbilityMatcher: AbilityMatcherProtocol {
    
    private let abilities: [String: Ability]
    
    public init(_ abilities: [Ability]) {
        self.abilities = abilities.toDictionary(with: { $0.name })
    }
    
    public func active(in state: StateProtocol) -> [GMove]? {
        let actor = state.hits.first?.player ?? state.turn
        return active(actor: actor, in: state)
    }
    
    public func triggered(on event: GEvent, in state: StateProtocol) -> [GMove]? {
        var actors = state.playOrder
        
        // <RULE>: trigger moves from just eliminated player
        if case let .eliminate(player, _) = event {
            actors.append(player)
        }
        // </RULE>
        
        return actors.compactMap { triggered(on: event, actor: $0, in: state) }
            .flatMap { $0 }
            .sorted(by: { abilities[$0.ability]!.priority < abilities[$1.ability]!.priority })
            .notEmptyOrNil()
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

private extension AbilityMatcher {
    
    func active(actor identifier: String, in state: StateProtocol) -> [GMove]? {
        let actor = state.players[identifier]!
        
        let innerMoves: [GMove] = actor.applicableAbilities().keys
            .compactMap { self.moves(ofType: .active, ability: $0, card: nil, actor: actor, in: state) }
            .flatMap { $0 }
        
        let playHandMoves: [GMove] = actor.hand.flatMap { card -> [GMove] in
            actor.abilities(applicableTo: card).keys
                .compactMap { ability -> [GMove]? in
                    self.moves(ofType: .active, ability: ability, card: .hand(card.identifier), actor: actor, in: state)?
                        .filter { move -> Bool in
                            if let target = move.args[.target]?.first,
                               let targetObject = state.players[target],
                               !targetObject.isTargetableBy(card) {
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
    
    func triggered(on event: GEvent, actor identifier: String, in state: StateProtocol) -> [GMove]? {
        let actor = state.players[identifier]!
        
        let innerMoves: [GMove] = actor.applicableAbilities().keys
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
        let ctx = MoveContext(ability: ability,
                              actor: actor,
                              card: card,
                              state: state,
                              event: event)
        var playArgs: [[PlayArg: [String]]] = []
        guard abilityObject.canPlay.allSatisfy({ $0.match(ctx, args: &playArgs) }) else {
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
        let applicableMoves = moves.filter { effects(on: $0, actor: actor, in: state) != nil }
        // </RULE>
        
        return applicableMoves
    }
    
    func effects(on move: GMove, actor: PlayerProtocol, in state: StateProtocol) -> [GEvent]? {
        // find ability
        guard let ability = abilities[move.ability] else {
            fatalError("Ability \(move.ability) not found")
        }
        
        let ctx = MoveContext(ability: move.ability,
                              actor: actor,
                              card: move.card,
                              state: state,
                              event: nil,
                              args: move.args)
        // build events
        var result: [GEvent] = []
        for effect in ability.onPlay {
            guard let events = effect.apply(ctx),
                  !events.isEmpty || effect.optional else {
                return nil
            }
            
            result.append(contentsOf: events)
        }
        
        return result.notEmptyOrNil()
    }
}

// MARK: - Passive ability matcher

private extension PlayerProtocol {
    
    func isTargetableBy(_ card: CardProtocol) -> Bool {
        if let regex = attributes.silentCard,
           card.matches(regex: regex) {
           return false
        }
        
        return true
    }
    
    func applicableAbilities() -> [String: Int] {
        var abilities = self.abilities
        if let silenced = attributes.silentAbility {
            abilities.removeValue(forKey: silenced)
        }
        return abilities
    }
    
    func abilities(applicableTo card: CardProtocol) -> [String: Int] {
        var abilities = card.abilities
        for (key, value) in attributes.playAs ?? [:] {
            if card.matches(regex: key) {
                abilities[value] = 0
            }
        }
        return abilities
    }
}
