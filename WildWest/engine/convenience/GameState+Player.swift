//
//  GameState+Player.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    var players: [PlayerProtocol] {
        allPlayers.filter { $0.health > 0 }
    }
    
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
    
    func nextPlayer(after playerId: String) -> String {
        guard let turnIndex = allPlayers.firstIndex(where: { $0.identifier == playerId }) else {
            fatalError("player \(playerId) not found")
        }
        
        let playersCount = allPlayers.count
        let sortedPlayers = Array(1..<playersCount).map { allPlayers[(turnIndex + $0) % playersCount] }
        guard let nextPlayer = sortedPlayers.first(where: { $0.health > 0 }) else {
            fatalError("Next player not found")
        }
        
        return nextPlayer.identifier
    }
}
