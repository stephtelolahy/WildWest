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
    var discardPile: [CardProtocol]
    var turn: String?
    var challenge: Challenge?
    var bangsPlayed: Int
    var damageEvents: [DamageEvent]
    var generalStore: [CardProtocol]
    var eliminated: [PlayerProtocol]
    var outcome: GameOutcome?
    var validMoves: [String: [GameMove]]
    var executedMoves: [GameMove]
    
    init(players: [PlayerProtocol],
         deck: [CardProtocol],
         discardPile: [CardProtocol],
         turn: String?,
         challenge: Challenge?,
         bangsPlayed: Int,
         damageEvents: [DamageEvent],
         generalStore: [CardProtocol],
         outcome: GameOutcome?,
         validMoves: [String: [GameMove]],
         executedMoves: [GameMove],
         eliminated: [PlayerProtocol]) {
        self.players = players
        self.deck = deck
        self.discardPile = discardPile
        self.turn = turn
        self.challenge = challenge
        self.bangsPlayed = bangsPlayed
        self.damageEvents = damageEvents
        self.generalStore = generalStore
        self.outcome = outcome
        self.executedMoves = executedMoves
        self.validMoves = validMoves
        self.eliminated = eliminated
    }
}
