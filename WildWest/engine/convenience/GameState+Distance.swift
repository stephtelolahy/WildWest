//
//  GameState+Distance.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func distance(from playerId: String, to otherId: String) -> Int {
        guard let pIndex = players.firstIndex(where: { $0.identifier == playerId }),
            let oIndex = players.firstIndex(where: { $0.identifier == otherId }),
            pIndex != oIndex else {
                return 0
        }
        
        let count = players.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + count - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + count - oIndex)
        var distance = min(rightDistance, leftDistance)
        
        distance -= players[pIndex].scopeCount
        
        distance += players[oIndex].mustangCount
        
        return distance
    }
}
