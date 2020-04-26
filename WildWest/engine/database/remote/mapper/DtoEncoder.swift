//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DtoEncoder {
    
    func encode(state: GameStateProtocol) -> StateDto {
        StateDto(order: encode(players: state.allPlayers),
                 players: encode(players: state.allPlayers),
                 deck: encode(cards: state.deck),
                 discardPile: encode(cards: state.discardPile),
                 turn: state.turn,
                 generalStore: encode(cards: state.generalStore),
                 outcome: state.outcome?.rawValue,
                 challenge: encode(challenge: state.challenge))
    }
    
    func encode(challenge: Challenge?) -> ChallengeDto? {
        guard let challenge = challenge else {
            return nil
        }
        
        return ChallengeDto(name: challenge.name.rawValue,
                            targetIds: challenge.targetIds,
                            damage: challenge.damage,
                            counterNeeded: challenge.counterNeeded,
                            barrelsPlayed: challenge.barrelsPlayed)
    }
}

private extension DtoEncoder {
    
    func encode(cards: [CardProtocol]) -> [String]? {
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { encode(card: $0) }
    }
    
    func encode(cards: [CardProtocol]) -> [String: Bool]? {
        guard !cards.isEmpty else {
            return nil
        }
        
        var result: [String: Bool] = [:]
        cards.forEach { card in
            let key = encode(card: card)
            result[key] = true
        }
        return result
    }
    
    func encode(card: CardProtocol) -> String {
        card.identifier
    }
    
    func encode(players: [PlayerProtocol]) -> [String] {
        players.map { $0.identifier }
    }
    
    func encode(players: [PlayerProtocol]) -> [String: PlayerDto] {
        var result: [String: PlayerDto] = [:]
        players.forEach { player in
            let dto = encode(player: player)
            result[player.identifier] = dto
        }
        return result
    }
    
    func encode(player: PlayerProtocol) -> PlayerDto {
        PlayerDto(role: player.role!.rawValue,
                  figureName: player.figureName.rawValue,
                  imageName: player.imageName,
                  description: player.description,
                  abilities: encode(abilities: player.abilities),
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: encode(cards: player.hand),
                  inPlay: encode(cards: player.inPlay),
                  bangsPlayed: player.bangsPlayed,
                  lastDamage: encode(damageEvent: player.lastDamage))
    }
    
    func encode(abilities: [AbilityName: Bool]) -> [String: Bool] {
        var result: [String: Bool] = [:]
        abilities.forEach { key, value in
            result[key.rawValue] = value
        }
        return result
    }
    
    func encode(damageEvent: DamageEvent?) -> DamageEventDto? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEventDto(damage: damageEvent.damage,
                              source: encode(damageSource: damageEvent.source))
        
    }
    
    func encode(damageSource: DamageSource) -> DamageSourceDto? {
        switch damageSource {
        case .byDynamite:
            return DamageSourceDto(byDynamite: true, byPlayer: nil)
            
        case let .byPlayer(playerId):
            return DamageSourceDto(byDynamite: nil, byPlayer: playerId)
        }
    }
}
