//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: MutableGameStateProtocol {
    
    let players: [PlayerProtocol]
    let deck: CardListProtocol
    let discard: CardListProtocol
    var turn: Int
    var outcome: GameOutcome?
    var messages: [String]
    
    init(players: [PlayerProtocol], deck: CardListProtocol, discard: CardListProtocol) {
        self.players = players
        self.deck = deck
        self.discard = discard
        turn = 0
        outcome = nil
        messages = []
    }
    
    func discard(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        player.hand.removeById(cardId)
        deck.add(card)
        addMessage("\(player.identifier) discard \(card.identifier)")
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
        addMessage("\(player.identifier) pull \(card.identifier) from deck")
    }
    
    func gainLifePoint(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        guard player.health < player.maxHealth else {
            return
        }
        
        player.setHealth(player.health + 1)
        addMessage("\(player.identifier) gain life point")
    }
    
    func equip(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        player.hand.removeById(cardId)
        player.inPlay.add(card)
        addMessage("\(player.identifier) equip with \(card.identifier)")
    }
}
