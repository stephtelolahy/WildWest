//
//  GameUpdateSetTurn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct GameUpdateSetTurn: GameUpdateProtocol {
    let turn: String
    
    var description: String {
        "setTurn \(turn)"
    }
    
    func execute(in database: GameDatabaseProtocol) {
        database.setTurn(turn)
        database.setBangsPlayed(0)
    }
}
