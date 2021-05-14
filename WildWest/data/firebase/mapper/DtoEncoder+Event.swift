//
//  DtoEncoder+Event.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 06/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation
import WildWestEngine

extension DtoEncoder {
    
    func decode(event: EventDto) throws -> GEvent {
        if event.emptyQueue != nil {
            return .emptyQueue
        }
        
        if event.revealDeck != nil {
            return .revealDeck
        }
        
        if event.deckToStore != nil {
            return .deckToStore
        }
        
        if let phase = event.setPhase {
            return .setPhase(value: phase)
        }
        
        if let player = event.setTurn {
            return .setTurn(player: player)
        }
        
        if let player = event.gainHealth {
            return .gainHealth(player: player)
        }
        
        if let player = event.drawDeck {
            return .drawDeck(player: player)
        }
        
        return .emptyQueue
    }
    
    func encode(event: GEvent) -> EventDto {
        switch event {
        case .emptyQueue:
            return EventDto(emptyQueue: true)
            
        case .revealDeck:
            return EventDto(revealDeck: true)
            
        case .deckToStore:
            return EventDto(deckToStore: true)
            
        case let .setPhase(value: phase):
            return EventDto(setPhase: phase)
            
        case let .setTurn(player):
            return EventDto(setTurn: player)
            
        case let .gainHealth(player: player):
            return EventDto(gainHealth: player)
            
        case let .drawDeck(player: player):
            return EventDto(drawDeck: player)
            
        default:
            return EventDto()
        }
    }
}
/*
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

/*
import Foundation

extension DtoEncoder {
    
    func encode(move: GameMove) -> GameMoveDto {
        GameMoveDto(name: move.name.rawValue,
                    actorId: move.actorId,
                    cardId: move.cardId,
                    targetId: move.targetId,
                    targetCard: encode(targetCard: move.targetCard),
                    discardIds: move.discardIds)
    }
    
    func decode(move: GameMoveDto) throws -> GameMove {
        GameMove(name: MoveName(try move.name.unwrap()),
                 actorId: try move.actorId.unwrap(),
                 cardId: move.cardId,
                 targetId: move.targetId,
                 targetCard: try decode(targetCard: move.targetCard),
                 discardIds: move.discardIds)
    }
}

private extension DtoEncoder {
    
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
*/
