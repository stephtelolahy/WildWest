//
//  GCard.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public class GCard: CardProtocol {
    
    // MARK: - Properties
    
    public let identifier: String
    public let name: String
    public let type: CardType
    public let desc: String
    public let attributes: [CardAttributeKey: Any]
    public let abilities: Set<String>
    public let suit: String
    public let value: String
    
    // MARK: Init
    
    public init(identifier: String,
                name: String,
                type: CardType,
                desc: String,
                attributes: [CardAttributeKey: Any],
                abilities: Set<String>,
                suit: String,
                value: String) {
        self.identifier = identifier
        self.name = name
        self.type = type
        self.desc = desc
        self.attributes = attributes
        self.abilities = abilities
        self.suit = suit
        self.value = value
    }
}
