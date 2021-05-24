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
}

public class ResourcesLoader: ResourcesLoaderProtocol {
    
    private let jsonReader: JsonReader
    
    public init(jsonReader: JsonReader) {
        self.jsonReader = jsonReader
    }
    
    public func loadCards() -> [Card] {
        jsonReader.load("bang-cards") + jsonReader.load("dodge-city-cards")
    }
    
    public func loadDeck() -> [DeckCard] {
        jsonReader.load("bang-deck") + jsonReader.load("dodge-city-deck")
    }
    
    public func loadAbilities() -> [Ability] {
        jsonReader.load("bang-abilities") + jsonReader.load("dodge-city-abilities")
    }
}
