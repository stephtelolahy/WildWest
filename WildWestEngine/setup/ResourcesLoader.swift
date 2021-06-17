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
        loadResourceArray(named: "cards")
    }
    
    public func loadDeck() -> [DeckCard] {
        loadResourceArray(named: "deck")
    }
    
    public func loadAbilities() -> [Ability] {
        loadResourceArray(named: "abilities")
    }
}

private extension ResourcesLoader {
    
    func loadResourceArray<T: Decodable>(named name: String) -> [T] {
        if let collection = self.collection {
            return jsonReader.load("\(collection.rawValue)-\(name)")
        } else {
            return CardCollection.allCases
                .map { collection -> [T] in
                    jsonReader.load("\(collection.rawValue)-\(name)")
                }
                .flatMap { $0 }
        }
    }
}
