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
    public let attributes: CardAttributes
    
    public init(name: String,
                desc: String = "",
                type: CardType,
                abilities: [String: Int] = [:],
                attributes: CardAttributes = CardAttributes()) {
        self.name = name
        self.desc = desc
        self.type = type
        self.abilities = abilities
        self.attributes = attributes
    }
}

public enum CardType: String, Decodable {
    case brown
    case blue
    case figure
    case `default`
}

public struct CardAttributes: CardAttributesProtocol {
    public let bullets: Int?
    public let mustang: Int?
    public let scope: Int?
    
    public init(bullets: Int? = nil,
                mustang: Int? = nil,
                scope: Int? = nil) {
        self.bullets = bullets
        self.mustang = mustang
        self.scope = scope
    }
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
        attributes = try values.decodeIfPresent(CardAttributes.self, forKey: .attributes) ?? CardAttributes()
    }
}

extension CardAttributes: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case bullets
        case mustang
        case scope
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bullets = try values.decodeIfPresent(Int.self, forKey: .bullets)
        mustang = try values.decodeIfPresent(Int.self, forKey: .mustang)
        scope = try values.decodeIfPresent(Int.self, forKey: .scope)
    }
}
