//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    let players: [PlayerProtocol]
    let deck: CardListProtocol
    let discard: CardListProtocol
    var turn: Int
    var outcome: GameOutcome?
    var commands: [ActionProtocol]
    var challenge: Challenge?
    
    init(players: [PlayerProtocol],
         deck: CardListProtocol,
         discard: CardListProtocol,
         turn: Int,
         outcome: GameOutcome?,
         commands: [ActionProtocol],
         challenge: Challenge?) {
        self.players = players
        self.deck = deck
        self.discard = discard
        self.turn = turn
        self.outcome = outcome
        self.commands = commands
        self.challenge = challenge
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
    
    func pullFromDeck(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if deck.cards.isEmpty {
            deck.addAll(discard.removeAll().shuffled())
        }
        
        if let card = deck.removeFirst() {
            player.hand.add(card)
        }
    }
    
    func discardHand(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = player.hand.removeById(cardId) {
            discard.add(card)
        }
    }
    
    func discardInPlay(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = player.inPlay.removeById(cardId) {
            discard.add(card)
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
        
        if let card = player.hand.removeById(cardId) {
            player.inPlay.add(card)
        }
    }
}
