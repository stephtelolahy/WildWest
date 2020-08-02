//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    var allPlayers: [PlayerProtocol]
    var deck: [CardProtocol]
    var discardPile: [CardProtocol]
    var turn: String
    var challenge: Challenge?
    var generalStore: [CardProtocol]
    var outcome: GameOutcome?
    
    init(allPlayers: [PlayerProtocol],
         deck: [CardProtocol],
         discardPile: [CardProtocol],
         turn: String,
         challenge: Challenge?,
         generalStore: [CardProtocol],
         outcome: GameOutcome?) {
        self.allPlayers = allPlayers
        self.deck = deck
        self.discardPile = discardPile
        self.turn = turn
        self.challenge = challenge
        self.generalStore = generalStore
        self.outcome = outcome
    }
}
