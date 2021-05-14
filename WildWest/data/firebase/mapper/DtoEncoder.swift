//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import WildWestEngine

class DtoEncoder {
    
    let databaseRef: DatabaseReferenceProtocol
    private let allCards: [CardProtocol]
    
    init(databaseRef: DatabaseReferenceProtocol, allCards: [CardProtocol]) {
        self.allCards = allCards
        self.databaseRef = databaseRef
    }
    
    func encode(card: CardProtocol) -> String {
        card.identifier
    }
    
    func decode(card: String) throws -> CardProtocol {
        try allCards.first(where: { $0.identifier == card }).unwrap()
    }
    
    func encode(cards: [CardProtocol]) -> [String: String] {
        cards.reduce([String: String]()) { dict, card in
            var dict = dict
            let key = self.databaseRef.childByAutoIdKey()
            dict[key] = encode(card: card)
            return dict
        }
    }
    
    func decode(cards: [String: String]?) throws -> [CardProtocol] {
        guard let cards = cards else {
            return []
        }
        
        let orderedKeys = cards.keys.sorted()
        return try orderedKeys.map { try decode(card: cards[$0].unwrap()) }
    }
}
