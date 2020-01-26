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
    var history: [ActionProtocol]
    var actions: [ActionProtocol]
    
    init(players: [PlayerProtocol],
         deck: CardListProtocol,
         discard: CardListProtocol,
         turn: Int,
         outcome: GameOutcome?,
         history: [ActionProtocol],
         actions: [ActionProtocol]) {
        self.players = players
        self.deck = deck
        self.discard = discard
        self.turn = turn
        self.outcome = outcome
        self.history = history
        self.actions = actions
    }
    
    func addHistory(_ action: ActionProtocol) {
        history.append(action)
    }
    
    func setActions(_ actions: [ActionProtocol]) {
        self.actions = actions
    }
    
    func pullFromDeck(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if let card = deck.removeFirst() {
            player.hand.add(card)
        } else {
            deck.addAll(discard.removeAll())
            if let card = deck.removeFirst() {
                player.hand.add(card)
            }
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
