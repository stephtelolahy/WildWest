//
//  GameResources.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 1/7/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GameResources: GameResourcesProtocol {
    
    private let jsonReader: JsonReaderProtocol
    
    init(jsonReader: JsonReaderProtocol ) {
        self.jsonReader = jsonReader
    }
    
    func allCards() -> [CardProtocol] {
        return jsonReader.load([Card].self, file: "cards")
    }
    
    func allFigures() -> [Figure] {
        return jsonReader.load([Figure].self, file: "figures")
    }
}
