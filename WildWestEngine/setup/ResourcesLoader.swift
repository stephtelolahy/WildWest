//
//  ResourcesLoader.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

public protocol ResourcesLoaderProtocol {
    func loadAbilities() -> [Ability]
    func loadCards() -> [Card]
    func loadDeck() -> [DeckCard]
    func loadDefaults() -> DefaultAbilities
}

public class ResourcesLoader: ResourcesLoaderProtocol {
    
    private let jsonReader: JsonReader
    
    public init(jsonReader: JsonReader) {
        self.jsonReader = jsonReader
    }
    
    public func loadAbilities() -> [Ability] {
        jsonReader.load("abilities")
    }
    
    public func loadCards() -> [Card] {
        jsonReader.load("cards")
    }
    
    public func loadDeck() -> [DeckCard] {
        jsonReader.load("deck")
    }
    
    public func loadDefaults() -> DefaultAbilities {
        jsonReader.load("defaults")
    }
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

extension Ability: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case canPlay
        case onPlay
        case priority
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(AbilityType.self, forKey: .type)
        canPlay = (try? values.decodeIfPresent([String: Any].self, forKey: .canPlay)) ?? [:]
        onPlay = try values.decode([[String: Any]].self, forKey: .onPlay)
        priority = (try? values.decodeIfPresent(Int.self, forKey: .priority)) ?? 1
    }
}

extension AbilityType: Decodable {}
