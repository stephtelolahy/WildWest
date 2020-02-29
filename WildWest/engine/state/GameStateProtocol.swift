//
//  GameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get }
    var deck: [CardProtocol] { get }
    var turn: String { get }
    var challenge: Challenge? { get }
    var bangsPlayed: Int { get }
    var barrelsResolved: Int { get }
    var generalStore: [CardProtocol] { get }
    var eliminated: [PlayerProtocol] { get }
    var outcome: GameOutcome? { get }
    var validMoves: [ActionProtocol] { get }
    var moves: [ActionProtocol] { get }
}

enum GameOutcome: String, Equatable {
    case sheriffWin,
    outlawWin,
    renegadeWin
}

enum Challenge: Equatable {
    case startTurn
    case startTurnDynamiteExploded
    case shoot([String], CardName)
    case indians([String])
    case duel([String])
    case generalStore([String])
}
