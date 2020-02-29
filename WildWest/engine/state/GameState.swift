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
    var damageEvents: [DamageEvent]
    var generalStore: [CardProtocol]
    var eliminated: [PlayerProtocol]
    var outcome: GameOutcome?
    var validMoves: [ActionProtocol]
    var moves: [ActionProtocol]
    
    init(players: [PlayerProtocol],
         deck: [CardProtocol],
         turn: String,
         challenge: Challenge?,
         bangsPlayed: Int,
         barrelsResolved: Int,
         damageEvents: [DamageEvent],
         generalStore: [CardProtocol],
         outcome: GameOutcome?,
         validMoves: [ActionProtocol],
         moves: [ActionProtocol],
         eliminated: [PlayerProtocol]) {
        self.players = players
        self.deck = deck
        self.turn = turn
        self.challenge = challenge
        self.bangsPlayed = bangsPlayed
        self.barrelsResolved = barrelsResolved
        self.damageEvents = damageEvents
        self.generalStore = generalStore
        self.outcome = outcome
        self.moves = moves
        self.validMoves = validMoves
        self.eliminated = eliminated
    }
}
