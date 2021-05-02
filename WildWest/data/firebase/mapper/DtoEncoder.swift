//
//  DtoEncoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

class DtoEncoder {
    /*
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
    
    func encode(orderedCards: [CardProtocol]) -> [String: String]? {
        guard !orderedCards.isEmpty else {
            return nil
        }
        
        var result: [String: String] = [:]
        
        orderedCards.forEach { card in
            let key = self.keyGenerator.autoId()
            result[key] = encode(card: card)
        }
        
        return result
    }
    
    func decode(orderedCards: [String: String]?) throws -> [CardProtocol] {
        guard let orderedCards = orderedCards else {
            return []
        }
        
        let orderedKeys = orderedCards.keys.sorted()
        return try orderedKeys.map { try decode(card: orderedCards[$0].unwrap()) }
    }
    
    func encode(cards: [CardProtocol]) -> [String: Bool]? {
        guard !cards.isEmpty else {
            return nil
        }
        
        var result: [String: Bool] = [:]
        cards.forEach { card in
            let key = encode(card: card)
            result[key] = true
        }
        return result
    }
    
    func decode(cards: [String: Bool]?) throws -> [CardProtocol] {
        guard let cards = cards else {
            return []
        }
        
        var result: [CardProtocol] = []
        try cards.forEach { key, _ in
            let card = try decode(card: key)
            result.append(card)
        }
        
        return result.sorted(by: { $0.identifier < $1.identifier })
    }
 */
}
