//
//  GameResources.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol GameResourcesProtocol {
    var allCards: [CardProtocol] { get }
    var allFigures: [FigureProtocol] { get }
}

class GameResources: GameResourcesProtocol {
    
    private let jsonReader: JsonReaderProtocol
    
    init(jsonReader: JsonReaderProtocol ) {
        self.jsonReader = jsonReader
    }
    
    var allCards: [CardProtocol] {
        jsonReader.load([Card].self, file: "cards")
    }
    
    var allFigures: [FigureProtocol] {
        jsonReader.load([FigureDto].self, file: "figures")
            .map { FigureMapper().map(dto: $0) }
    }
}
