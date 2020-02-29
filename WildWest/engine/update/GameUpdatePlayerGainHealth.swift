//
//  GameUpdatePlayerGainHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdatePlayerGainHealth: GameUpdateProtocol {
    let playerId: String
    let health: Int
    
    var description: String {
        "\(playerId) gain health to \(health)"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        database.playerSetHealth(playerId, health)
    }
}
