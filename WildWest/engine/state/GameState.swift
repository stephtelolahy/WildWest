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
        self.generalStore = generalStore
        self.outcome = outcome
        self.commands = commands
        self.actions = actions
        self.eliminated = eliminated
    }
    /*
    func eliminate(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let playerIndex = players.firstIndex(where: { $0.identifier == playerId }) else {
                return
        }
        
        player.hand.forEach { discardHand(playerId: playerId, cardId: $0.identifier) }
        player.inPlay.forEach { discardInPlay(playerId: playerId, cardId: $0.identifier) }
        
        // active player is eliminated, update turn and trigger startTurn challenge
        if playerId == turn {
            let nextPlayerIndex = (playerIndex + 1) % players.count
            let nextPlayerId = players[nextPlayerIndex].identifier
            turn = nextPlayerId
            challenge = .startTurn
        }
        
        players.remove(at: playerIndex)
        
        eliminated.append(player)
        
        outcome = Self.calculateOutcome(with: players)
    }
    
    private static func calculateOutcome(with players: [PlayerProtocol]) -> GameOutcome? {
        let allOutlawsAreEliminated = players.filter { $0.role == .outlaw || $0.role == .renegade }.isEmpty
        if allOutlawsAreEliminated {
            return .sheriffWin
        }
        
        let sheriffIsEliminated = players.filter { $0.role == .sheriff }.isEmpty
        if sheriffIsEliminated {
            let lastPlayerIsRenegade = players.count == 1 && players[0].role == .renegade
            if lastPlayerIsRenegade {
                return .renegadeWin
            } else {
                return .outlawWin
            }
        }
        
        return nil
    }
 */
}
