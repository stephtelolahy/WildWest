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
    public let attributes: Attributes
    
    public init(name: String,
                desc: String = "",
                type: CardType,
                abilities: [String: Int] = [:],
                attributes: Attributes = Attributes()) {
        self.name = name
        self.desc = desc
        self.type = type
        self.abilities = abilities
        self.attributes = attributes
    }
    
    public struct Attributes {
        public let bullets: Int?
        
        public init(bullets: Int? = nil) {
            self.bullets = bullets
        }
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
        case abilities
        case attributes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        desc = try values.decode(String.self, forKey: .desc)
        type = try values.decode(CardType.self, forKey: .type)
        abilities = try values.decodeIfPresent([String: Int].self, forKey: .abilities) ?? [:]
        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes) ?? Card.Attributes()
    }
}

extension Card.Attributes: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case bullets
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bullets = try values.decodeIfPresent(Int.self, forKey: .bullets)
    }
}
