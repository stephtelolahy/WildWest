//
//  DtoDecoder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DtoDecoder {
    
    private let allCards: [CardProtocol]
    
    init(allCards: [CardProtocol]) {
        self.allCards = allCards
    }
    
    func map(dto: StateDto) -> GameStateProtocol {
        fatalError()
    }
}
