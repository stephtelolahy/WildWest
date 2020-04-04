//
//  GameState+Turn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    var nextTurn: String {
        guard let turnIndex = allPlayers.firstIndex(where: { $0.identifier == turn }) else {
            fatalError("player ot found")
        }
        
        var nextIndex = turnIndex
        repeat {
            nextIndex = (nextIndex + 1) % allPlayers.count
        } while allPlayers[nextIndex].health == 0
        
        return allPlayers[nextIndex].identifier
    }
}
