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
    
    func addAll(_ elements: [CardProtocol]) {
        cards += elements
    }
    
    func removeAll() {
        cards.removeAll()
    }
    
    func removeFirst() -> CardProtocol {
        return cards.removeFirst()
    }
    
    func removeById(_ identifier: String) {
        return cards.removeAll { $0.identifier == identifier }
    }
}
