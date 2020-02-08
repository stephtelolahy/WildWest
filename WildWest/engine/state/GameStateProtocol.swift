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
    var turn: String { get }
    var challenge: Challenge? { get }
    var bangsPlayed: Int { get }
    var generalStoreCards: [CardProtocol] { get }
    var outcome: GameOutcome? { get }
    var actions: [GenericAction] { get }
    var commands: [ActionProtocol] { get }
    var eliminated: [PlayerProtocol] { get }
    
    func setActions(_ actions: [GenericAction])
    func discardHand(playerId: String, cardId: String)
    func discardInPlay(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pullDeck(playerId: String)
    func putInPlay(playerId: String, cardId: String)
    func addCommand(_ action: ActionProtocol)
    func setChallenge(_ challenge: Challenge?)
    func setTurn(_ turn: String)
    func setBangsPlayed(_ count: Int)
    func setupGeneralStore(count: Int)
    func pullGeneralStore(playerId: String, cardId: String)
    func pullHand(playerId: String, otherId: String, cardId: String)
    func pullInPlay(playerId: String, otherId: String, cardId: String)
    func looseLifePoint(playerId: String)
    func eliminate(playerId: String)
}

enum GameOutcome: String {
    case sheriffWin,
    outlawWin,
    renegadeWin
}

enum Challenge: Equatable {
    case startTurn
    case shoot([String])
    case indians([String])
    case duel([String])
    case generalStore([String])
}
