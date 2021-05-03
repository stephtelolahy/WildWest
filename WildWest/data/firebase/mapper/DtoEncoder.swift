//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation
import WildWestEngine

class DtoEncoder {
    
    private let allCards: [CardProtocol]
    private let keyGenerator: KeyGeneratorProtocol
    
    init(allCards: [CardProtocol],
         keyGenerator: KeyGeneratorProtocol) {
        self.allCards = allCards
        self.keyGenerator = keyGenerator
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
            let key = self.keyGenerator.autoId()
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
