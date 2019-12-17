//
//  GainLifePoints.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct GainLifePoints: StateUpdateProtocol {
    
    let player: PlayerProtocol
    let points: Int
    
    func apply(to state: GameStateProtocol) {
        player.setHealth(player.health + points)
        state.addMessage("\(player.identifier) gain \(points) life points")
    }
}
