//
//  CardList.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class CardList: CardListProtocol {
    
    var cards: [CardProtocol]
    
    init(cards: [CardProtocol]) {
        self.cards = cards
    }
    
    func add(_ card: CardProtocol) {
        cards.append(card)
    }
    
    func pull() -> CardProtocol {
        return cards.remove(at: 0)
    }
    
    func remove(_ card: CardProtocol) {
        return cards.removeAll { $0.identifier == card.identifier }
    }
}
