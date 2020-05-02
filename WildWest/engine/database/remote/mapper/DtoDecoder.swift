//
//  DtoDecoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

class DtoDecoder {
    
    private let allCards: [CardProtocol]
    
    init(allCards: [CardProtocol]) {
        self.allCards = allCards
    }
    
    func decode(state: GameStateDto) throws -> GameStateProtocol {
        GameState(allPlayers: try decode(players: state.players, order: state.order),
                  deck: try decode(orderedCards: state.deck),
                  discardPile: try decode(orderedCards: state.discardPile).reversed(),
                  turn: try state.turn.unwrap(),
                  challenge: try decode(challenge: state.challenge),
                  generalStore: try decode(cards: state.generalStore),
                  outcome: try decode(outcome: state.outcome))
    }
    
    func decode(card: String) throws -> CardProtocol {
        try allCards.first(where: { $0.identifier == card }).unwrap()
    }
    
    func decode(move: GameMoveDto) throws -> GameMove {
        GameMove(name: MoveName(try move.name.unwrap()),
                 actorId: try move.actorId.unwrap(),
                 cardId: move.cardId,
                 targetId: move.targetId,
                 targetCard: try decode(targetCard: move.targetCard),
                 discardIds: move.discardIds)
    }
    
    func decode(update: GameUpdateDto) throws -> GameUpdate {
        fatalError()
    }
}

private extension DtoDecoder {
    
    func decode(orderedCards: [String: String]?) throws -> [CardProtocol] {
        guard let orderedCards = orderedCards else {
            return []
        }
        
        let orderedKeys = orderedCards.keys.sorted()
        return try orderedKeys.map { try decode(card: orderedCards[$0].unwrap()) }
    }
    
    func decode(cards: [String: Bool]?) throws -> [CardProtocol] {
        guard let cards = cards else {
            return []
        }
        
        var result: [CardProtocol] = []
        try cards.forEach { key, _ in
            let card = try decode(card: key)
            result.append(card)
        }
        
        return result.sorted(by: { $0.identifier < $1.identifier })
    }
    
    func decode(challenge: ChallengeDto?) throws -> Challenge? {
        guard let challenge = challenge else {
            return nil
        }
        
        return try Challenge(name: MoveName(challenge.name.unwrap()),
                             targetIds: challenge.targetIds ?? [],
                             damage: try challenge.damage.unwrap(),
                             counterNeeded: try challenge.counterNeeded.unwrap(),
                             barrelsPlayed: try challenge.barrelsPlayed.unwrap())
    }
    
    func decode(outcome: String?) throws -> GameOutcome? {
        guard let outcome = outcome else {
            return nil
        }
        
        return try GameOutcome(rawValue: outcome).unwrap()
    }
    
    func decode(players: [String: PlayerDto]?, order: [String]?) throws -> [PlayerProtocol] {
        let playersDtos = try players.unwrap()
        return try order.unwrap().map { key in
            let dto = try playersDtos[key].unwrap()
            return try self.decode(player: dto)
        }
    }
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        Player(identifier: try player.identifier.unwrap(),
               role: try Role(rawValue: try player.role.unwrap()).unwrap(),
               figureName: try FigureName(rawValue: try player.figureName.unwrap()).unwrap(),
               imageName: try player.imageName.unwrap(),
               description: try player.description.unwrap(),
               abilities: try decode(abilities: player.abilities),
               maxHealth: try player.maxHealth.unwrap(),
               health: try player.health.unwrap(),
               hand: try decode(cards: player.hand),
               inPlay: try decode(cards: player.inPlay),
               bangsPlayed: try player.bangsPlayed.unwrap(),
               lastDamage: try decode(damageEvent: player.lastDamage))
    }
    
    func decode(abilities: [String: Bool]?) throws -> [AbilityName: Bool] {
        guard let abilities = abilities else {
            return [:]
        }
        
        var result: [AbilityName: Bool] = [:]
        try abilities.forEach { key, value in
            let ability = try AbilityName(rawValue: key).unwrap()
            result[ability] = value
        }
        return result
    }
    
    func decode(damageEvent: DamageEventDto?) throws -> DamageEvent? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEvent(damage: try damageEvent.damage.unwrap(),
                           source: try decode(damageSource: try damageEvent.source.unwrap()))
    }
    
    func decode(damageSource: DamageSourceDto) throws -> DamageSource {
        if damageSource.byDynamite == true {
            return .byDynamite
        }
        
        if let playerId = damageSource.byPlayer {
            return .byPlayer(playerId)
        }
        
        throw NSError(domain: "invalid DamageSourceDto", code: 0)
    }
    
    func decode(targetCard: TargetCardDto?) throws -> TargetCard? {
        guard let targetCard = targetCard else {
            return nil
        }
        
        return TargetCard(ownerId: try targetCard.ownerId.unwrap(),
                          source: try decode(targetCardSource: try targetCard.source.unwrap()))
    }
    
    func decode(targetCardSource: TargetCardSourceDto) throws -> TargetCardSource {
        if targetCardSource.randomHand == true {
            return .randomHand
        }
        
        if let cardId = targetCardSource.inPlay {
            return .inPlay(cardId)
        }
        
        throw NSError(domain: "invalid TargetCardSourceDto", code: 0)
    }
    
}
