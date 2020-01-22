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
    var outcome: GameOutcome? { get }
    var messages: [String] { get }
    var turn: Int { get }
    
    func discardHand(playerId: String, cardId: String)
    func discardInPlay(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pull(playerId: String)
    func putInPlay(playerId: String, cardId: String)
}

enum GameOutcome {
    case sheriffWin,
    outlawWin,
    renegadeWin
}
