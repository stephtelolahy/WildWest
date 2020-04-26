//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DtoEncoder {
    
    func encode(state: GameStateProtocol) -> StateDto {
        StateDto(players: state.allPlayers.map { encode(player: $0) },
                 deck: state.deck.map { encode(card: $0) },
                 discardPile: state.discardPile.map { encode(card: $0) },
                 turn: state.turn,
                 generalStore: state.generalStore.map { encode(card: $0) },
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
    
    func encode(card: CardProtocol) -> String {
        card.identifier
    }
    
    func encode(player: PlayerProtocol) -> PlayerDto {
        PlayerDto(role: player.role!.rawValue,
                  figureName: player.figureName.rawValue,
                  imageName: player.imageName,
                  description: player.description,
                  abilities: encode(abilities: player.abilities),
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: player.hand.map { encode(card: $0) },
                  inPlay: player.inPlay.map { encode(card: $0) },
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
