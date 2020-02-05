//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    var players: [PlayerProtocol]
    let deck: DeckProtocol
    var turn: Int
    var challenge: Challenge?
    var turnShoots: Int
    var generalStoreCards: [CardProtocol]
    var outcome: GameOutcome?
    var commands: [ActionProtocol]
    var actions: [GenericAction]
    var eliminated: [PlayerProtocol]
    
    init(players: [PlayerProtocol],
         deck: DeckProtocol,
         turn: Int,
         challenge: Challenge?,
         turnShoots: Int,
         generalStoreCards: [CardProtocol],
         outcome: GameOutcome?,
         actions: [GenericAction],
         commands: [ActionProtocol],
         eliminated: [PlayerProtocol]) {
        self.players = players
        self.deck = deck
        self.turn = turn
        self.challenge = challenge
        self.turnShoots = turnShoots
        self.generalStoreCards = generalStoreCards
        self.outcome = outcome
        self.commands = commands
        self.actions = actions
        self.eliminated = eliminated
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
    
    func setupGeneralStore(count: Int) {
        generalStoreCards = Array(1...count).map { _ in deck.pull() }
    }
    
    func pullGeneralStore(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let cardIndex = generalStoreCards.firstIndex(where: { $0.identifier == cardId }) else {
                return
        }
        
        let card = generalStoreCards[cardIndex]
        generalStoreCards.remove(at: cardIndex)
        player.addHand(card)
    }
    
    func pullDeck(playerId: String) {
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
    
    func looseLifePoint(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        player.setHealth(player.health - 1)
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
    
    func eliminate(playerId: String) {
        guard let playerIndex = players.firstIndex(where: { $0.identifier == playerId }) else {
            return
        }
        
        let player = players[playerIndex]
        player.hand.forEach { discardHand(playerId: playerId, cardId: $0.identifier) }
        player.inPlay.forEach { discardInPlay(playerId: playerId, cardId: $0.identifier) }
        eliminated.append(player)
        
        let turnPlayerId = players[turn].identifier
        players.remove(at: playerIndex)
        guard let turnPlayerIndex = players.firstIndex(where: { $0.identifier == turnPlayerId }) else {
            return
        }
        
        turn = turnPlayerIndex
    }
}
