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
    case setBangsPlayed(Int)
    case setBarrelsResolved(Int)
    case setOutcome(GameOutcome)
    case playerSetHealth(String, Int)
    case playerPullFromDeck(String)
    case playerDiscardHand(String, String)
    case playerPutInPlay(String, String)
    case playerDiscardInPlay(String, String)
    case playerPullFromOtherHand(String, String, String)
    case playerPullFromOtherInPlay(String, String, String)
    case playerPutInPlayOfOther(String, String, String)
    case playerPassInPlayOfOther(String, String, String)
    case playerPullFromGeneralStore(String, String)
    case setupGeneralStore(Int)
    case flipOverFirstDeckCard
    case eliminatePlayer(String)
}

extension GameUpdate: GameUpdateProtocol {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func execute(in database: GameDatabaseProtocol) {
        switch self {
        case let .setTurn(turn):
            database.setTurn(turn)
            database.setBangsPlayed(0)
            
        case let .setOutcome(outcome):
            database.setOutcome(outcome)
            
        case let .setChallenge(challenge):
            database.setChallenge(challenge)
            switch challenge {
            case let .startTurn(turn):
                database.setTurn(turn)
            case .shoot:
                database.setBarrelsResolved(0)
            default:
                break
            }
            
        case let .setBangsPlayed(count):
            database.setBangsPlayed(count)
            
        case let .setBarrelsResolved(count):
            database.setBarrelsResolved(count)
            
        case let .playerPullFromDeck(playerId):
            let card = database.deckRemoveFirst()
            database.playerAddHand(playerId, card)
            
        case let .playerDiscardHand(playerId, cardId):
            if let card = database.playerRemoveHand(playerId, cardId) {
                database.addDiscard(card)
            }
            
        case let .playerSetHealth(playerId, health):
            database.playerSetHealth(playerId, health)
            
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
            let card = database.deckRemoveFirst()
            database.addDiscard(card)
            
        case let .eliminatePlayer(playerId):
            let cards = database.playerRemoveAllHand(playerId) + database.playerRemoveAllInPlay(playerId)
            cards.forEach { database.addDiscard($0) }
            if let player = database.removePlayer(playerId) {
                database.addEliminated(player)
            }
        }
    }
    
    var description: String {
        switch self {
        case let .setTurn(turn):
            return "setTurn \(turn)"
            
        case let .setOutcome(outcome):
            return "setOutcome \(outcome)"
            
        case let .setChallenge(challenge):
            return "setChallenge \(challenge?.description ?? "nil")"
            
        case let .setBangsPlayed(count):
            return "setBangsPlayed \(count)"
            
        case let .setBarrelsResolved(count):
            return "setBarrelsResolved \(count)"
            
        case let .playerPullFromDeck(playerId):
            return "\(playerId) pullFromDeck "
            
        case let .playerDiscardHand(playerId, cardId):
            return "\(playerId) discardHand \(cardId)"
            
        case let .playerSetHealth(playerId, health):
            return "\(playerId) setHealth \(health)"
            
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
            return "flipOverFirstDeckCard"
            
        case let .eliminatePlayer(playerId):
            return "eliminate \(playerId)"
        }
    }
}
