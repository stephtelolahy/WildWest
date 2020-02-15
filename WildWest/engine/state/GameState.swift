//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    var players: [PlayerProtocol]
    var deck: [CardProtocol]
    var turn: String
    var challenge: Challenge?
    var bangsPlayed: Int
    var barrelsResolved: Int
    var generalStore: [CardProtocol]
    var outcome: GameOutcome?
    var commands: [ActionProtocol]
    var actions: [ActionProtocol]
    var eliminated: [PlayerProtocol]
    
    init(players: [PlayerProtocol],
         deck: [CardProtocol],
         turn: String,
         challenge: Challenge?,
         bangsPlayed: Int,
         barrelsResolved: Int,
         generalStore: [CardProtocol],
         outcome: GameOutcome?,
         actions: [ActionProtocol],
         commands: [ActionProtocol],
         eliminated: [PlayerProtocol]) {
        self.players = players
        self.deck = deck
        self.turn = turn
        self.challenge = challenge
        self.bangsPlayed = bangsPlayed
        self.barrelsResolved = barrelsResolved
        self.generalStore = generalStore
        self.outcome = outcome
        self.commands = commands
        self.actions = actions
        self.eliminated = eliminated
    }
}
