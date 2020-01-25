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
    
    func removeAll() -> [CardProtocol] {
        let array = cards
        cards.removeAll()
        return array
    }
    
    func removeFirst() -> CardProtocol? {
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.removeFirst()
    }
    
    func removeById(_ identifier: String) -> CardProtocol? {
        guard let index = cards.firstIndex(where: { $0.identifier == identifier }) else {
            return nil
        }
        let shouldBeRemoved = cards[index]
        cards.remove(at: index)
        return shouldBeRemoved
    }
}
