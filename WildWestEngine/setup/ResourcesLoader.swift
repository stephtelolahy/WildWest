//
//  ResourcesLoader.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 03/10/2020.
//

public enum CardCollection: String, CaseIterable {
    case bang
    case dodgecity
}

public protocol ResourcesLoaderProtocol {
    func loadCards() -> [Card]
    func loadDeck() -> [DeckCard]
    func loadAbilities() -> [Ability]
}

public class ResourcesLoader: ResourcesLoaderProtocol {
    
    private let jsonReader: JsonReader
    private let collection: CardCollection?
    
    public init(jsonReader: JsonReader, collection: CardCollection? = nil) {
        self.jsonReader = jsonReader
        self.collection = collection
    }
    
    public func loadCards() -> [Card] {
        if let collection = self.collection {
            return jsonReader.load("\(collection.rawValue)-cards")
        } else {
            return CardCollection.allCases
                .map { collection -> [Card] in
                    jsonReader.load("\(collection.rawValue)-cards")
                }
                .flatMap { $0 }
        }
    }
    
    public func loadDeck() -> [DeckCard] {
        if let collection = self.collection {
            return jsonReader.load("\(collection.rawValue)-deck")
        } else {
            return CardCollection.allCases
                .map { collection -> [DeckCard] in
                    jsonReader.load("\(collection.rawValue)-deck")
                }
                .flatMap { $0 }
        }
    }
    
    public func loadAbilities() -> [Ability] {
        if let collection = self.collection {
            return jsonReader.load("\(collection.rawValue)-abilities")
        } else {
            return CardCollection.allCases
                .map { collection -> [Ability] in
                    jsonReader.load("\(collection.rawValue)-abilities")
                }
                .flatMap { $0 }
        }
    }
}
