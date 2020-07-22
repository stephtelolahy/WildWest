//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

class DtoEncoder {
    
    private let keyGenerator: KeyGeneratorProtocol
    
    init(keyGenerator: KeyGeneratorProtocol) {
        self.keyGenerator = keyGenerator
    }
    
    func encode(state: GameStateProtocol) -> GameStateDto {
        GameStateDto(order: encode(orderOf: state.allPlayers),
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
            let key = self.keyGenerator.autoId()
            result[key] = encode(card: card)
        }
        
        return result
    }
    
    func encode(move: GameMove) -> GameMoveDto {
        GameMoveDto(name: move.name.rawValue,
                    actorId: move.actorId,
                    cardId: move.cardId,
                    targetId: move.targetId,
                    targetCard: encode(targetCard: move.targetCard),
                    discardIds: move.discardIds)
    }
    
    func encode(update: GameUpdate) -> GameUpdateDto {
        switch update {
        case let .setTurn(turn):
            return GameUpdateDto(setTurn: turn)
            
        case let .setChallenge(challenge):
            if let challenge = challenge {
                return GameUpdateDto(setChallenge: encode(challenge: challenge))
            } else {
                return GameUpdateDto(removeChallenge: true)
            }
        case let .playerSetBangsPlayed(playerId, count):
            let arg = PlayerSetBangsPlayedDto(playerId: playerId, count: count)
            return GameUpdateDto(playerSetBangsPlayed: arg)
            
        case let .playerSetHealth(playerId, health):
            let arg = PlayerSetHealthDto(playerId: playerId, health: health)
            return GameUpdateDto(playerSetHealth: arg)
            
        case let .playerSetDamage(playerId, damageEvent):
            let arg = PlayerSetDamageDto(playerId: playerId, event: encode(damageEvent: damageEvent))
            return GameUpdateDto(playerSetDamage: arg)
            
        case let .playerPullFromDeck(playerId):
            return GameUpdateDto(playerPullFromDeck: playerId)
            
        case let .playerDiscardHand(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerDiscardHand: arg)
            
        case let .playerPutInPlay(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerPutInPlay: arg)
            
        case let .playerDiscardInPlay(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerDiscardInPlay: arg)
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            let arg = PlayerManipulatesOtherCardDto(playerId: playerId, otherId: otherId, cardId: cardId)
            return GameUpdateDto(playerPullFromOtherHand: arg)
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            let arg = PlayerManipulatesOtherCardDto(playerId: playerId, otherId: otherId, cardId: cardId)
            return GameUpdateDto(playerPullFromOtherInPlay: arg)
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            let arg = PlayerManipulatesOtherCardDto(playerId: playerId, otherId: otherId, cardId: cardId)
            return GameUpdateDto(playerPutInPlayOfOther: arg)
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            let arg = PlayerManipulatesOtherCardDto(playerId: playerId, otherId: otherId, cardId: cardId)
            return GameUpdateDto(playerPassInPlayOfOther: arg)
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerPullFromGeneralStore: arg)
            
        case let .playerRevealHandCard(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerRevealHandCard: arg)
            
        case let .setupGeneralStore(cardsCount):
            return GameUpdateDto(setupGeneralStore: cardsCount)
            
        case .flipOverFirstDeckCard:
            return GameUpdateDto(flipOverFirstDeckCard: true)
        }
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
