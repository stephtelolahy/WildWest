//
//  GameState+Turn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    var nextTurn: String {
        guard let turnIndex = players.firstIndex(where: { $0.identifier == turn }) else {
            return ""
        }
        
        let nextPlayerIndex = (turnIndex + 1) % players.count
        return players[nextPlayerIndex].identifier
    }
    
}
