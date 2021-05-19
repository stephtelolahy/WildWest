//
//  Card.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

public struct Card {
    public let name: String
    public let desc: String
    public let type: CardType
    public let abilities: [String: Int]
    
    public init(name: String,
                desc: String = "",
                type: CardType,
                abilities: [String: Int] = [:]) {
        self.name = name
        self.desc = desc
        self.type = type
        self.abilities = abilities
    }
}

public enum CardType: String {
    case brown
    case blue
    case figure
}
