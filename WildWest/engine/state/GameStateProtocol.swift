//
//  GameStateProtocol.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/17/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get }
    var allPlayers: [PlayerProtocol] { get }
    var deck: [CardProtocol] { get }
    var discardPile: [CardProtocol] { get }
    var turn: String? { get }
    var challenge: Challenge? { get }
    var generalStore: [CardProtocol] { get }
    var outcome: GameOutcome? { get }
    var validMoves: [String: [GameMove]] { get }
    var executedMoves: [GameMove] { get }
}

enum GameOutcome: String, Equatable {
    case sheriffWin,
    outlawWin,
    renegadeWin
}
