//
//  ResourcesManager.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol ResourcesManagerProtocol {
    func allCards() -> [Card]
}

class ResourcesManager: ResourcesManagerProtocol {
    
    private let jsonReader: JsonReaderProtocol
    
    init(jsonReader: JsonReaderProtocol ) {
        self.jsonReader = jsonReader
    }
    
    func allCards() -> [Card] {
        return jsonReader.load([Card].self, file: "cards")
    }
}
