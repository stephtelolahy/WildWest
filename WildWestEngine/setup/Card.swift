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
    public let attributes: [CardAttributeKey: Any]
    public let abilities: Set<String>
    
    public init(name: String,
                type: CardType,
                desc: String,
                attributes: [CardAttributeKey: Any],
                abilities: Set<String>) {
        self.name = name
        self.desc = desc
        self.type = type
        self.attributes = attributes
        self.abilities = abilities
    }
}

public enum CardType: String, Decodable {
    case brown
    case blue
    case figure
    case `default`
}

extension Card: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case desc
        case type
        case attributes
        case abilities
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        desc = try values.decode(String.self, forKey: .desc)
        type = try values.decode(CardType.self, forKey: .type)
        attributes = try values.decodeIfPresent([String: Any].self, forKey: .attributes)?
            .reduce(into: [:]) { result, element in
                result[CardAttributeKey(rawValue: element.key)!] = element.value
            }
            ?? [:]
        abilities = Set(try values.decodeIfPresent([String].self, forKey: .abilities) ?? [])
    }
}
