//
//  ResourcesLoader.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

public protocol ResourcesLoaderProtocol {
    func loadCards() -> [Card]
    func loadDeck() -> [DeckCard]
    func loadAbilities() -> [Ability]
    func loadGAbilities() -> [GAbility]
}

public class ResourcesLoader: ResourcesLoaderProtocol {
    
    private let jsonReader: JsonReader
    
    public init(jsonReader: JsonReader) {
        self.jsonReader = jsonReader
    }
    
    public func loadCards() -> [Card] {
        jsonReader.load("cards")
    }
    
    public func loadDeck() -> [DeckCard] {
        jsonReader.load("deck")
    }
    
    public func loadAbilities() -> [Ability] {
        jsonReader.load("abilities")
    }
    
    public func loadGAbilities() -> [GAbility] {
        jsonReader.load("parsable-abilities")
    }
}
