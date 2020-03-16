//
//  GameUpdate.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

enum GameUpdate: Equatable {
    case setTurn(String)
    case setChallenge(Challenge?)
    case flipOverFirstDeckCard
    case eliminatePlayer(String)
    case playerGainHealth(String, Int)
    case playerLooseHealth(String, Int, DamageSource)
    
    case playerPullFromDeck(String, Int)
    case playerDiscardHand(String, String)
    case playerPutInPlay(String, String)
    case playerDiscardInPlay(String, String)
    case playerPullFromOtherHand(String, String, String)
    case playerPullFromOtherInPlay(String, String, String)
    case playerPutInPlayOfOther(String, String, String)
    case playerPassInPlayOfOther(String, String, String)
    case playerPullFromGeneralStore(String, String)
    case setupGeneralStore(Int)
    case setOutcome(GameOutcome)
}

enum GameUpdateE: Equatable {
    
    struct Class1: Equatable {
        let prop: String
    }
}

extension GameUpdate: GameUpdateProtocol {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func execute(in database: GameDatabaseProtocol) {
        switch self {
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
    
    var description: String {
        switch self {
        case let .setTurn(turn):
            return GameUpdateSetTurn(turn: turn).description
            
        case let .setChallenge(challenge):
            return GameUpdateSetChallenge(challenge: challenge).description
            
        case let .playerGainHealth(playerId, points):
            return GameUpdatePlayerGainHealth(playerId: playerId, points: points).description
            
        case let .playerLooseHealth(playerId, points, source):
            return GameUpdatePlayerLooseHealth(playerId: playerId, points: points, source: source).description
            
        case let .playerPullFromDeck(playerId, cardsCount):
            return "\(playerId) pullFromDeck \(cardsCount)"
            
        case let .playerDiscardHand(playerId, cardId):
            return "\(playerId) discardHand \(cardId)"
            
        case let .playerPutInPlay(playerId, cardId):
            return "\(playerId) putInPlay \(cardId)"
            
        case let .playerDiscardInPlay(playerId, cardId):
            return "\(playerId) discardInPlay \(cardId)"
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            return "\(playerId) pullFromOtherHand \(otherId) \(cardId)"
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            return "\(playerId) pullFromOtherInPlay \(otherId) \(cardId)"
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            return "\(playerId) putInPlayOfOther \(otherId) \(cardId)"
            
        case let .playerPassInPlayOfOther(playerId, otherId, cardId):
            return "\(playerId) passInPlayOfOther \(otherId) \(cardId)"
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            return "\(playerId) pullFromGeneralStore \(cardId)"
            
        case let .setupGeneralStore(cardsCount):
            return "setupGeneralStore \(cardsCount)"
            
        case .flipOverFirstDeckCard:
            return GameUpdateFlipOverFirstDeckCard().description
            
        case let .eliminatePlayer(playerId):
            return GameUpdateEliminatePlayer(playerId: playerId).description
            
        case let .setOutcome(outcome):
            return "setOutcome \(outcome)"
        }
    }
}
