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
    var outcome: GameOutcome? { get }
    var validMoves: [ActionProtocol] { get }
    var commandsHistory: [ActionProtocol] { get }
    var eliminated: [PlayerProtocol] { get }
}

enum GameOutcome: String, Equatable {
    case sheriffWin,
    outlawWin,
    renegadeWin
}

enum Challenge: Equatable {
    case startTurn(String)
    case shoot([String])
    case indians([String])
    case duel([String])
    case generalStore([String])
    case dynamiteExplode(String)
}
