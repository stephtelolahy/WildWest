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
    
    func addMessage(_ message: String)
    func discard(playerId: String, cardId: String)
    func gainLifePoint(playerId: String)
    func pull(playerId: String)
    func matchingCards(playerId: String, cardName: CardName) -> [CardProtocol]
}

enum GameOutcome {
    case sheriffWins,
    outlawWin,
    renegadeWins
}
