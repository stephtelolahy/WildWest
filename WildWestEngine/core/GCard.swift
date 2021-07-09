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
    public let abilities: [String: Int]
    public let attributes: CardAttributesProtocol
    public let suit: String
    public let value: String
    
    // MARK: Init
    
    public init(identifier: String,
                name: String,
                type: CardType,
                desc: String,
                abilities: [String: Int],
                attributes: CardAttributesProtocol,
                suit: String,
                value: String) {
        self.identifier = identifier
        self.name = name
        self.type = type
        self.desc = desc
        self.abilities = abilities
        self.attributes = attributes
        self.suit = suit
        self.value = value
    }
}
