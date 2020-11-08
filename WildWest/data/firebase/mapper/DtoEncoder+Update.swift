//
//  DtoEncoder+Update.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length
/*
import Foundation

extension DtoEncoder {
    
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
            
        case let .playerPullFromDiscard(playerId):
            return GameUpdateDto(playerPullFromDiscard: playerId)
            
        case let .playerDiscardHand(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerDiscardHand: arg)
            
        case let .playerDiscardTopDeck(playerId, cardId):
            let arg = PlayerManipulatesCardDto(playerId: playerId, cardId: cardId)
            return GameUpdateDto(playerDiscardTopDeck: arg)
            
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
    
    func decode(update: GameUpdateDto) throws -> GameUpdate {
        if let turn = update.setTurn {
            return .setTurn(turn)
        }
        
        if let arg = update.setChallenge,
            let challenge = try decode(challenge: arg) {
            return .setChallenge(challenge)
        }
        
        if update.removeChallenge == true {
            return .setChallenge(nil)
        }
        
        if update.flipOverFirstDeckCard == true {
            return .flipOverFirstDeckCard
        }
        
        if let cardsCount = update.setupGeneralStore {
            return .setupGeneralStore(cardsCount)
        }
        
        if let playerId = update.playerPullFromDeck {
            return .playerPullFromDeck(playerId)
        }
        
        if let playerId = update.playerPullFromDiscard {
            return .playerPullFromDiscard(playerId)
        }
        
        if let arg = update.playerSetBangsPlayed,
            let playerId = arg.playerId,
            let count = arg.count {
            return .playerSetBangsPlayed(playerId, count)
        }
        
        if let arg = update.playerSetHealth,
            let playerId = arg.playerId,
            let health = arg.health {
            return .playerSetHealth(playerId, health)
        }
        
        if let arg = update.playerSetDamage,
            let playerId = arg.playerId,
            let eventDto = arg.event,
            let event = try decode(damageEvent: eventDto) {
            return .playerSetDamage(playerId, event)
        }
        
        if let arg = update.playerDiscardHand,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerDiscardHand(playerId, cardId)
        }
        
        if let arg = update.playerDiscardTopDeck,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerDiscardTopDeck(playerId, cardId)
        }
        
        if let arg = update.playerPutInPlay,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerPutInPlay(playerId, cardId)
        }
        
        if let arg = update.playerDiscardInPlay,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerDiscardInPlay(playerId, cardId)
        }
        
        if let arg = update.playerPullFromGeneralStore,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerPullFromGeneralStore(playerId, cardId)
        }
        
        if let arg = update.playerRevealHandCard,
            let playerId = arg.playerId,
            let cardId = arg.cardId {
            return .playerRevealHandCard(playerId, cardId)
        }
        
        if let arg = update.playerPullFromOtherHand,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPullFromOtherHand(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPullFromOtherInPlay,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPullFromOtherInPlay(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPutInPlayOfOther,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPutInPlayOfOther(playerId, otherId, cardId)
        }
        
        if let arg = update.playerPassInPlayOfOther,
            let playerId = arg.playerId,
            let otherId = arg.otherId,
            let cardId = arg.cardId {
            return .playerPassInPlayOfOther(playerId, otherId, cardId)
        }
        
        throw NSError(domain: "invalid GameUpdateDto", code: 0)
    }
}
*/
