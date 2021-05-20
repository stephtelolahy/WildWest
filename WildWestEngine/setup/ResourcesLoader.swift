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
