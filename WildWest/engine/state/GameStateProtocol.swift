//
//  GameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get }
    var deck: DeckProtocol { get }
    var turn: Int { get }
    var challenge: Challenge? { get }
    var turnShoots: Int { get }
    var outcome: GameOutcome? { get }
    var commands: [ActionProtocol] { get }
    
    func discardHand(playerId: String, cardId: String)
    func discardInPlay(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pullFromDeck(playerId: String)
    func putInPlay(playerId: String, cardId: String)
    func addCommand(_ action: ActionProtocol)
    func setChallenge(_ challenge: Challenge?)
    func setTurn(_ turn: Int)
    func setTurnShoots(_ shoots: Int)
    func pullHand(playerId: String, otherId: String, cardId: String)
    func pullInPlay(playerId: String, otherId: String, cardId: String)
}

enum GameOutcome {
    case sheriffWin,
    outlawWin,
    renegadeWin
}

enum Challenge: Equatable {
    case startTurn
    case bang(actorId: String, targetId: String)
    case duel
    case indians
    case generalStore
}
