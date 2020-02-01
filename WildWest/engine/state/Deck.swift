//
//  Deck.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 30/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class Deck: DeckProtocol {
    var cards: [CardProtocol]
    var discardPile: [CardProtocol]
    
    init(cards: [CardProtocol], discardPile: [CardProtocol]) {
        self.cards = cards
        self.discardPile = discardPile
    }
    
    func pull() -> CardProtocol {
        if cards.isEmpty {
            cards = discardPile.shuffled()
            discardPile = []
        }
        
        return cards.removeFirst()
    }
    
    func addToDiscard(_ card: CardProtocol) {
        discardPile.insert(card, at: 0)
    }
}
