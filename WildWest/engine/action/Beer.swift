//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Beer: GameActionProtocol {
    
    let playerIdentifier: String
    let cardIdentifier: String
    
    func execute() -> [GameUpdateProtocol] {
        return [
            Discard(playerIdentifier: playerIdentifier, cardIdentifier: cardIdentifier),
            GainLifePoints(playerIdentifier: playerIdentifier, points: 1)
        ]
    }
}
