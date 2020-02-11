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
    case playerPullCardFromDeck(String)
    case playerDiscardHand(String, String)
    case playerSetHealth(String, Int)
}

extension GameUpdate: GameUpdateProtocol {
    func execute(in state: MutableGameStateProtocol) {
        switch self {
        case let .setTurn(turn):
            state.setTurn(turn)
            
        case let .setChallenge(challenge):
            state.setChallenge(challenge)
            
        case let .setBangsPlayed(count):
            state.setBangsPlayed(count)
            
        case let .playerPullCardFromDeck(playerId):
            let card = state.deckRemoveFirst()
            state.playerAddHandCard(playerId, card)
            
        case let .playerDiscardHand(playerId, cardId):
            if let card = state.playerRemoveHandCard(playerId, cardId) {
                state.addDiscard(card)
            }
            
        case let .playerSetHealth(playerId, health):
            state.playerSetHealth(playerId, health)
        }
    }
}
