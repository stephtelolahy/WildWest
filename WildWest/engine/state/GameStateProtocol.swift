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
    var discardPile: [CardProtocol] { get }
    var turn: String? { get }
    var challenge: Challenge? { get }
    var bangsPlayed: Int { get }
    @available(*, deprecated)
    var barrelsResolved: Int { get }
    @available(*, deprecated)
    var generalStore: [CardProtocol] { get }
    var eliminated: [PlayerProtocol] { get }
    var outcome: GameOutcome? { get }
    var validMoves: [String: [GameMove]] { get }
    var executedMoves: [GameMove] { get }
    var damageEvents: [DamageEvent] { get }
}

enum GameOutcome: String, Equatable {
    case sheriffWin,
    outlawWin,
    renegadeWin
}
