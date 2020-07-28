//
//  GameDatabase+Update.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import RxSwift

extension GameDatabaseProtocol {
    func execute(_ update: GameUpdate) -> Completable {
        switch update {
        case let .setTurn(turn):
            return setTurn(turn)
            
        case let .setChallenge(challenge):
            return setChallenge(challenge)
            
        case let .playerSetBangsPlayed(playerId, count):
            return playerSetBangsPlayed(playerId, count)
            
        case let .playerSetHealth(playerId, health):
            return playerSetHealth(playerId, health)
            
        case let .playerSetDamage(playerId, damageEvent):
            return playerSetDamageEvent(playerId, damageEvent)
            
        case let .playerPullFromDeck(playerId):
            return deckRemoveFirst()
                .flatMapCompletable { self.playerAddHand(playerId, $0) }
            
        case let .playerPullFromDiscard(playerId):
            return discardRemoveFirst()
                .flatMapCompletable { self.playerAddHand(playerId, $0) }
            
        case let .playerDiscardHand(playerId, cardId):
            return playerRemoveHand(playerId, cardId)
                .flatMapCompletable { self.addDiscard($0) }
            
        case let .playerPutInPlay(playerId, cardId):
            return playerRemoveHand(playerId, cardId)
                .flatMapCompletable { self.playerAddInPlay(playerId, $0) }
            
        case let .playerDiscardInPlay(playerId, cardId):
            return playerRemoveInPlay(playerId, cardId)
                .flatMapCompletable { self.addDiscard($0) }
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            return playerRemoveHand(otherId, cardId)
                .flatMapCompletable { self.playerAddHand(playerId, $0) }
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            return playerRemoveInPlay(otherId, cardId)
                .flatMapCompletable { self.playerAddHand(playerId, $0) }
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            return playerRemoveHand(playerId, cardId)
                .flatMapCompletable { self.playerAddInPlay(otherId, $0) }
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            return playerRemoveInPlay(playerId, cardId)
                .flatMapCompletable { self.playerAddInPlay(otherId, $0) }
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            return removeGeneralStore(cardId)
                .flatMapCompletable { self.playerAddHand(playerId, $0) }
            
        case let .setupGeneralStore(cardsCount):
            let transactions = Array(1...cardsCount).map { _ in
                self.deckRemoveFirst()
                    .flatMapCompletable { self.addGeneralStore($0) }
            }
            return Completable.concat(transactions)
            
        case .flipOverFirstDeckCard:
            return deckRemoveFirst()
                .flatMapCompletable { self.addDiscard($0) }
            
        default:
            return Completable.empty()
        }
    }
}
