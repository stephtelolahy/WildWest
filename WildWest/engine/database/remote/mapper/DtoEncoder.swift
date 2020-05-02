//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

class DtoEncoder {
    
    private let keyGenerator: FirebaseKeyGeneratorProtocol
    
    init(keyGenerator: FirebaseKeyGeneratorProtocol) {
        self.keyGenerator = keyGenerator
    }
    
    func encode(state: GameStateProtocol) -> StateDto {
        StateDto(order: encode(orderOf: state.allPlayers),
                 players: encode(players: state.allPlayers),
                 deck: encode(orderedCards: state.deck),
                 discardPile: encode(orderedCards: state.discardPile.reversed()),
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
    
    func encode(damageEvent: DamageEvent?) -> DamageEventDto? {
        guard let damageEvent = damageEvent else {
            return nil
        }
        
        return DamageEventDto(damage: damageEvent.damage,
                              source: encode(damageSource: damageEvent.source))
        
    }
    
    func encode(orderedCards: [CardProtocol]) -> [String: String]? {
        guard !orderedCards.isEmpty else {
            return nil
        }
        
        var result: [String: String] = [:]
        
        orderedCards.forEach { card in
            let key = self.keyGenerator.cardAutoId()
            result[key] = encode(card: card)
        }
        
        return result
    }
    
    func encode(move: GameMove) -> MoveDto {
        MoveDto(name: move.name.rawValue,
                actorId: move.actorId,
                cardId: move.cardId,
                targetId: move.targetId,
                targetCard: encode(targetCard: move.targetCard),
                discardIds: move.discardIds)
    }
    
    func encode(update: GameUpdate) -> UpdateDto {
        fatalError()
    }
}

private extension DtoEncoder {
    
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
    
    func encode(orderOf players: [PlayerProtocol]) -> [String] {
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
        PlayerDto(identifier: player.identifier,
                  role: player.role!.rawValue,
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
    
    func encode(damageSource: DamageSource) -> DamageSourceDto? {
        switch damageSource {
        case .byDynamite:
            return DamageSourceDto(byDynamite: true)
            
        case let .byPlayer(playerId):
            return DamageSourceDto(byPlayer: playerId)
        }
    }
    
    func encode(targetCard: TargetCard?) -> TargetCardDto? {
        guard let targetCard = targetCard else {
            return nil
        }
        
        return TargetCardDto(ownerId: targetCard.ownerId,
                             source: encode(targetCardSource: targetCard.source))
    }
    
    func encode(targetCardSource: TargetCardSource) -> TargetCardSourceDto {
        switch targetCardSource {
        case .randomHand:
            return TargetCardSourceDto(randomHand: true)
            
        case let .inPlay(cardId):
            return TargetCardSourceDto(inPlay: cardId)
        }
    }
}
