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
    
    func decode(dto: StateDto) throws -> GameStateProtocol {
        GameState(allPlayers: try dto.players.unwrap().map { try decode(player: $0) },
                  deck: try decode(cards: dto.deck),
                  discardPile: try decode(cards: dto.discardPile),
                  turn: try dto.turn.unwrap(),
                  challenge: try decode(challenge: dto.challenge),
                  generalStore: try decode(cards: dto.generalStore),
                  outcome: try decode(outcome: dto.outcome))
    }
}

private extension DtoDecoder {
    
    func decode(cards: [String]?) throws -> [CardProtocol] {
        guard let cards = cards else {
            return []
        }
        
        return try cards.map { try decode(card: $0) }
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
        
        return result
    }
    
    func decode(card: String) throws -> CardProtocol {
        guard let matchingCard = allCards.first(where: { $0.identifier == card }) else {
            throw NSError(domain: "matching card not found", code: 0)
        }
        
        return matchingCard
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
    
    func decode(player: PlayerDto) throws -> PlayerProtocol {
        Player(role: try Role(rawValue: try player.role.unwrap()).unwrap(),
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
        
        throw NSError(domain: "matching damage source not found", code: 0)
    }
    
}
