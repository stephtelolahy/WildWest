//
//  GameUpdateEliminatePlayer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdateEliminatePlayer: GameUpdateProtocol {
    let playerId: String
    
    var description: String {
        "eliminate \(playerId)"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        if let player = database.removePlayer(playerId) {
            database.addEliminated(player)
        }
    }
}
