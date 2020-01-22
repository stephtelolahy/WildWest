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
    var messages: [String]
    
    init(players: [PlayerProtocol],
         deck: CardListProtocol,
         discard: CardListProtocol,
         turn: Int,
         outcome: GameOutcome?,
         messages: [String]) {
        self.players = players
        self.deck = deck
        self.discard = discard
        self.turn = turn
        self.outcome = outcome
        self.messages = messages
    }
    
    func discardHand(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        player.hand.removeById(cardId)
        deck.add(card)
        messages.append("\(player.identifier) discard \(card.identifier)")
    }
    
    func discardInPlay(playerId: String, cardId: String) {
    }
    
    func pull(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        if deck.cards.isEmpty {
            let cards = discard.cards.shuffled()
            discard.removeAll()
            deck.addAll(cards)
        }
        
        let card = deck.removeFirst()
        player.hand.add(card)
        messages.append("\(player.identifier) pull \(card.identifier)")
    }
    
    func gainLifePoint(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        guard player.health < player.maxHealth else {
            return
        }
        
        player.setHealth(player.health + 1)
        messages.append("\(player.identifier) gain life point")
    }
    
    func putInPlay(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        player.hand.removeById(cardId)
        player.inPlay.add(card)
        messages.append("\(player.identifier) put in play \(card.identifier)")
    }
}
