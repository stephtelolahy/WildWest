//
//  GameUpdatePlayerGainHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdatePlayerGainHealth: GameUpdateProtocol {
    let playerId: String
    let points: Int
    
    var description: String {
        "\(playerId) gain \(points) life points"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        guard let player = database.state.players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        let health = player.health + points
        database.playerSetHealth(playerId, health)
    }
}
