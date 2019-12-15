//
//  GainLifePoints.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct GainLifePoints: GameUpdateProtocol {
    
    let playerIdentifier: String
    let points: Int
    
    func apply(to game: GameStateProtocol) {
        guard let player = game.players.first(where: { $0.identifier == playerIdentifier }) else {
            return
        }
        
        player.setHealth(player.health + points)
        game.addMessage("\(playerIdentifier) gain \(points) life points")
    }
}
