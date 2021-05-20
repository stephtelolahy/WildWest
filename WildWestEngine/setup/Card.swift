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

extension Card: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case desc
        case type
        case abilities
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        desc = try values.decode(String.self, forKey: .desc)
        type = try values.decode(CardType.self, forKey: .type)
        abilities = try values.decodeIfPresent([String: Int].self, forKey: .abilities) ?? [:]
    }
}

extension CardType: Decodable {}
