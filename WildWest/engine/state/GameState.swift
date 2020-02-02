//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    let players: [PlayerProtocol]
    let deck: DeckProtocol
    var turn: Int
    var challenge: Challenge?
    var turnShoots: Int
    var outcome: GameOutcome?
    var commands: [ActionProtocol]
    var actions: [GenericAction]
    
    init(players: [PlayerProtocol],
         deck: DeckProtocol,
         turn: Int,
         challenge: Challenge?,
         turnShoots: Int,
         outcome: GameOutcome?,
         actions: [GenericAction],
         commands: [ActionProtocol]) {
        self.players = players
        self.deck = deck
        self.turn = turn
        self.challenge = challenge
        self.turnShoots = turnShoots
        self.outcome = outcome
        self.commands = commands
        self.actions = actions
    }
    
    func setActions(_ actions: [GenericAction]) {
        self.actions = actions
    }
    
    func addCommand(_ action: ActionProtocol) {
        commands.append(action)
    }
    
    func setChallenge(_ challenge: Challenge?) {
        self.challenge = challenge
    }
    
    func setTurn(_ turn: Int) {
        self.turn = turn
    }
    
    func setTurnShoots(_ shoots: Int) {
        self.turnShoots = shoots
    }
    
    func pullFromDeck(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        player.addHand(deck.pull())
    }
    
    func discardHand(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = player.removeHandById(cardId) {
            deck.addToDiscard(card)
        }
    }
    
    func discardInPlay(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = player.removeInPlayById(cardId) {
            deck.addToDiscard(card)
        }
    }
    
    func gainLifePoint(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        player.setHealth(player.health + 1)
    }
    
    func putInPlay(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = player.removeHandById(cardId) {
            player.addInPlay(card)
        }
    }
    
    func pullHand(playerId: String, otherId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let other = players.first(where: { $0.identifier == otherId }) else {
                return
        }
        
        if let card = other.removeHandById(cardId) {
            player.addHand(card)
        }
    }
    
    func pullInPlay(playerId: String, otherId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let other = players.first(where: { $0.identifier == otherId }) else {
                return
        }
        
        if let card = other.removeInPlayById(cardId) {
            player.addHand(card)
        }
    }
}
