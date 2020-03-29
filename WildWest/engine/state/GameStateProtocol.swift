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

struct Challenge: Equatable {
    let name: ChallengeName
    var actorId: String?
    var targetIds: [String]?
}

enum ChallengeName: String {
    case startTurn
    case bang
    case duel
    case gatling
    case indians
    case generalStore
    case dynamiteExploded
    case discardExcessCards
}

struct DamageEvent: Equatable {
    let playerId: String
    let source: DamageSource
}

enum DamageSource: Equatable {
    case byDynamite
    case byPlayer(String)
}
