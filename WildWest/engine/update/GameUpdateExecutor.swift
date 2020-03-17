//
//  GameUpdateExecutor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameUpdateExecutor: GameUpdateExecutorProtocol {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func execute(_ update: GameUpdate, in database: GameDatabaseProtocol) {
        switch update {
        case let .setTurn(turn):
            GameUpdateSetTurn(turn: turn).execute(in: database)
            
        case let .setChallenge(challenge):
            GameUpdateSetChallenge(challenge: challenge).execute(in: database)
            
        case let .playerGainHealth(playerId, points):
            GameUpdatePlayerGainHealth(playerId: playerId, points: points).execute(in: database)
            
        case let .playerLooseHealth(playerId, points, source):
            GameUpdatePlayerLooseHealth(playerId: playerId, points: points, source: source).execute(in: database)
            
        case let .playerPullFromDeck(playerId, cardsCount):
            Array(1...cardsCount).forEach { _ in
                let card = database.deckRemoveFirst()
                database.playerAddHand(playerId, card)
            }
            
        case let .playerDiscardHand(playerId, cardId):
            if let card = database.playerRemoveHand(playerId, cardId) {
                database.addDiscard(card)
            }
            
        case let .playerPutInPlay(playerId, cardId):
            if let card = database.playerRemoveHand(playerId, cardId) {
                database.playerAddInPlay(playerId, card)
            }
            
        case let .playerDiscardInPlay(playerId, cardId):
            if let card = database.playerRemoveInPlay(playerId, cardId) {
                database.addDiscard(card)
            }
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            if let card = database.playerRemoveHand(otherId, cardId) {
                database.playerAddHand(playerId, card)
            }
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            if let card = database.playerRemoveInPlay(otherId, cardId) {
                database.playerAddHand(playerId, card)
            }
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            if let card = database.playerRemoveHand(playerId, cardId) {
                database.playerAddInPlay(otherId, card)
            }
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            if let card = database.playerRemoveInPlay(playerId, cardId) {
                database.playerAddInPlay(otherId, card)
            }
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            if let card = database.removeGeneralStore(cardId) {
                database.playerAddHand(playerId, card)
            }
            
        case let .setupGeneralStore(cardsCount):
            Array(1...cardsCount)
                .map { _ in database.deckRemoveFirst() }
                .compactMap { $0 }
                .forEach { database.addGeneralStore($0) }
            
        case .flipOverFirstDeckCard:
            GameUpdateFlipOverFirstDeckCard().execute(in: database)
            
        case let .eliminatePlayer(playerId):
            GameUpdateEliminatePlayer(playerId: playerId).execute(in: database)
            
        case let .setOutcome(outcome):
            database.setOutcome(outcome)
        }
    }
}
