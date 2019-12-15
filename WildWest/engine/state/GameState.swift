//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var players: [PlayerProtocol] { get }
    var deck: CardListProtocol { get }
    var discard: CardListProtocol { get }
    var outcome: GameOutcome? { get }
    var messages: [String] { get }
    var turn: Int { get } // current player index
    
    func endTurn()
    func addMessage(_ message: String)
}

enum GameOutcome {
    case sheriffWins,
    outlawWin,
    renegadeWins
}
