//
//  GameUpdatePlayerLooseHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdatePlayerLooseHealth: GameUpdateProtocol {
    let playerId: String
    let points: Int
    let source: DamageEvent.Source
    
    var description: String {
        "\(playerId) looses \(points) life points \(source)"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        guard let player = database.state.players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        let health = max(0, player.health - points)
        database.playerSetHealth(playerId, health)
        database.addDamageEvent(DamageEvent(playerId: playerId, source: source))
    }
}
