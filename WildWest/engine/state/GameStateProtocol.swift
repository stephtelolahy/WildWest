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
//    var actions: [ActionProtocol] { get } // possible actions
    var history: [ActionProtocol] { get } // actions history
    
    func discardHand(playerId: String, cardId: String)
    func discardInPlay(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pull(playerId: String)
    func putInPlay(playerId: String, cardId: String)
    func addHistory(_ action: ActionProtocol)
}

enum GameOutcome {
    case sheriffWin,
    outlawWin,
    renegadeWin
}
