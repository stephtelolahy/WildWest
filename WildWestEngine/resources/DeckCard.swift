//
//  DeckCard.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

public struct DeckCard: Decodable {
    public let name: String
    public let value: String
    public let suit: String
    
    public init(name: String,
                value: String,
                suit: String) {
        self.name = name
        self.value = value
        self.suit = suit
    }
}
