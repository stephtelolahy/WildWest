//
//  ResourcesManager.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol ResourcesManagerProtocol {
    func allCards() -> [Card]
    func allFigures() -> [Figure]
    func roles(for playersCount: Int) -> [Role]
}

class ResourcesManager: ResourcesManagerProtocol {
    
    private let jsonReader: JsonReaderProtocol
    
    init(jsonReader: JsonReaderProtocol ) {
        self.jsonReader = jsonReader
    }
    
    func allCards() -> [Card] {
        return jsonReader.load([Card].self, file: "cards")
    }
    
    func allFigures() -> [Figure] {
        return jsonReader.load([Figure].self, file: "figures")
    }
    
    func roles(for playersCount: Int) -> [Role] {
        guard playersCount >= 4 && playersCount <= 7 else {
            return []
        }
        
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy]
        return Array(order.prefix(playersCount))
    }
}
