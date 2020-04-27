//
//  GameUpdateExecutor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import RxSwift

class GameUpdateExecutor: UpdateExecutorProtocol {
    
    func execute(_ update: GameUpdate, in database: GameDatabaseProtocol) -> Completable {
        switch update {
        case let .setTurn(turn):
            return database.setTurn(turn)
            
        case let .setChallenge(challenge):
            return database.setChallenge(challenge)
            
        case let .playerSetBangsPlayed(playerId, count):
            return database.playerSetBangsPlayed(playerId, count)
            
        case let .playerGainHealth(playerId, health):
            return database.playerSetHealth(playerId, health)
            
        case let .playerLooseHealth(playerId, health, damageEvent):
            return database.playerSetHealth(playerId, health)
                .andThen(database.playerSetDamageEvent(playerId, damageEvent))
            
        case let .playerPullFromDeck(playerId):
            return database.deckRemoveFirst()
                .flatMapCompletable { database.playerAddHand(playerId, $0) }
            
        case let .playerDiscardHand(playerId, cardId):
            return database.playerRemoveHand(playerId, cardId)
                .flatMapCompletable { database.addDiscard($0) }
            
        case let .playerPutInPlay(playerId, cardId):
            return database.playerRemoveHand(playerId, cardId)
                .flatMapCompletable { database.playerAddInPlay(playerId, $0) }
            
        case let .playerDiscardInPlay(playerId, cardId):
            return database.playerRemoveInPlay(playerId, cardId)
                .flatMapCompletable { database.addDiscard($0) }
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            return database.playerRemoveHand(otherId, cardId)
                .flatMapCompletable { database.playerAddHand(playerId, $0) }
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            return database.playerRemoveInPlay(otherId, cardId)
                .flatMapCompletable { database.playerAddHand(playerId, $0) }
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            return database.playerRemoveHand(playerId, cardId)
                .flatMapCompletable { database.playerAddInPlay(otherId, $0) }
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            return database.playerRemoveInPlay(playerId, cardId)
                .flatMapCompletable { database.playerAddInPlay(otherId, $0) }
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            return database.removeGeneralStore(cardId)
                .flatMapCompletable { database.playerAddHand(playerId, $0) }
            
        case let .setupGeneralStore(cardsCount):
            let transactions = Array(1...cardsCount).map { _ in
                database.deckRemoveFirst()
                    .flatMapCompletable { database.addGeneralStore($0) }
            }
            return Completable.concat(transactions)
            
        case .flipOverFirstDeckCard:
            return database.deckRemoveFirst()
                .flatMapCompletable { database.addDiscard($0) }
            
        default:
            return Completable.empty()
        }
    }
}
