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
    case playerSetHealth(String, Int)
    case playerPullFromDeck(String)
    case playerDiscardHand(String, String)
    case playerPutInPlay(String, String)
    case playerDiscardInPlay(String, String)
    case playerPullFromOtherHand(String, String, String)
    case playerPullFromOtherInPlay(String, String, String)
    case playerPutInPlayOfOther(String, String, String)
    case playerPullFromGeneralStore(String, String)
    case setupGeneralStore(Int)
    case flipOverFirstDeckCard
    case eliminatePlayer(String)
}

extension GameUpdate: GameUpdateProtocol {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func execute(in state: MutableGameStateProtocol) {
        switch self {
        case let .setTurn(turn):
            state.setTurn(turn)
            
        case let .setChallenge(challenge):
            state.setChallenge(challenge)
            
        case let .setBangsPlayed(count):
            state.setBangsPlayed(count)
            
        case let .playerPullFromDeck(playerId):
            let card = state.deckRemoveFirst()
            state.playerAddHand(playerId, card)
            
        case let .playerDiscardHand(playerId, cardId):
            if let card = state.playerRemoveHand(playerId, cardId) {
                state.addDiscard(card)
            }
            
        case let .playerSetHealth(playerId, health):
            state.playerSetHealth(playerId, health)
            
        case let .playerPutInPlay(playerId, cardId):
            if let card = state.playerRemoveHand(playerId, cardId) {
                state.playerAddInPlay(playerId, card)
            }
            
        case let .playerDiscardInPlay(playerId, cardId):
            if let card = state.playerRemoveInPlay(playerId, cardId) {
                state.addDiscard(card)
            }
            
        case let .playerPullFromOtherHand(playerId, otherId, cardId):
            if let card = state.playerRemoveHand(otherId, cardId) {
                state.playerAddHand(playerId, card)
            }
            
        case let .playerPullFromOtherInPlay(playerId, otherId, cardId):
            if let card = state.playerRemoveInPlay(otherId, cardId) {
                state.playerAddHand(playerId, card)
            }
            
        case let .playerPutInPlayOfOther(playerId, otherId, cardId):
            if let card = state.playerRemoveHand(playerId, cardId) {
                state.playerAddInPlay(otherId, card)
            }
            
        case let .playerPullFromGeneralStore(playerId, cardId):
            if let card = state.removeGeneralStore(cardId) {
                state.playerAddHand(playerId, card)
            }
            
        case let .setupGeneralStore(cardsCount):
            Array(1...cardsCount)
                .map { _ in state.deckRemoveFirst() }
                .compactMap { $0 }
                .forEach { state.addGeneralStore($0) }
            
        case .flipOverFirstDeckCard:
            let card = state.deckRemoveFirst()
            state.addDiscard(card)
            
        case let .eliminatePlayer(playerId):
            if let player = state.removePlayer(playerId) {
                state.addEliminated(player)
            }
        }
    }
}
