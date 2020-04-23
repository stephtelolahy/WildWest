//
//  GameUpdateExecutor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameUpdateExecutor: UpdateExecutorProtocol {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    func execute(_ update: GameUpdate, in database: GameDatabaseProtocol) {
        switch update {
        case let .setTurn(turn):
            database.setTurn(turn)
            database.playerSetBangsPlayed(turn, 0)
            
        case let .setChallenge(challenge):
            database.setChallenge(challenge)
            if let challenge = challenge {
                if case .bang = challenge.name,
                    let actor = database.state.player(database.state.turn) {
                    database.playerSetBangsPlayed(actor.identifier, actor.bangsPlayed + 1)
                }
            }
            
        case let .playerGainHealth(playerId, points):
            if let player = database.state.player(playerId) {
                let health = player.health + points
                database.playerSetHealth(playerId, health)
            }
            
        case let .playerLooseHealth(playerId, points, source):
            if let player = database.state.player(playerId) {
                let health = max(0, player.health - points)
                database.playerSetHealth(playerId, health)
                database.playerSetDamageEvent(playerId, DamageEvent(damage: points, source: source))
            }
            
        case let .playerPullFromDeck(playerId):
            let card = database.deckRemoveFirst()
            database.playerAddHand(playerId, card)
            
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
                .compactMap { _ in database.deckRemoveFirst() }
                .forEach { database.addGeneralStore($0) }
            
        case .flipOverFirstDeckCard:
            let card = database.deckRemoveFirst()
            database.addDiscard(card)
            
        default:
            break
        }
    }
}

extension GameDatabaseProtocol {
    var state: GameStateProtocol {
        guard let value = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        return value
    }
}
