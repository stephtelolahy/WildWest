//
//  GameUpdatePlayerLooseHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdatePlayerLooseHealth: GameUpdateProtocol {
    let playerId: String
    let health: Int
    let source: DamageEvent.Source
    
    var description: String {
        "\(playerId) looses health \(health) \(source)"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        database.playerSetHealth(playerId, health)
        database.addDamageEvent(DamageEvent(playerId: playerId, source: source))
    }
}
