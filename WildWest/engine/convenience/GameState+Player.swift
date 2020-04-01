//
//  GameState+Player.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func player(_ playerId: String?) -> PlayerProtocol? {
        players.first(where: { $0.identifier == playerId })
    }
    
    // Other player identifiers clockwise
    func otherPlayerIds(_ playerId: String) -> [String] {
        guard let index = players.firstIndex(where: { $0.identifier == playerId }) else {
            fatalError("player \(playerId) not found")
        }
        
        let playersCount = players.count
        return Array(1..<playersCount).map { players[(index + $0) % playersCount].identifier }
    }
    
    // All player identifiers clockwise
    func allPlayerIds(_ playerId: String) -> [String] {
        guard let index = players.firstIndex(where: { $0.identifier == playerId }) else {
            fatalError("player \(playerId) not found")
        }
        
        let playersCount = players.count
        return Array(0..<playersCount).map { players[(index + $0) % playersCount].identifier }
    }
}
