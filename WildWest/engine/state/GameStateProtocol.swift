//
//  GameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get }
    var deck: CardListProtocol { get }
    var discard: CardListProtocol { get }
    var turn: Int { get }
    var outcome: GameOutcome? { get }
    var history: [ActionProtocol] { get }
    var actions: [ActionProtocol] { get }
    var challenge: Challenge? { get }
    
    func discardHand(playerId: String, cardId: String)
    func discardInPlay(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pullFromDeck(playerId: String)
    func putInPlay(playerId: String, cardId: String)
    func addHistory(_ action: ActionProtocol)
    func setActions(_ actions: [ActionProtocol])
    func setChallenge(_ challenge: Challenge?)
    func setTurn(_ turn: Int)
}

enum GameOutcome {
    case sheriffWin,
    outlawWin,
    renegadeWin
}

enum Challenge: Equatable {
    case startTurn
    case bang(actorId: String, targetId: String)
    case duel(actorId: String)
    case gatling(actorId: String)
    case indians(actorId: String)
    case generalStore(actorId: String)
}
