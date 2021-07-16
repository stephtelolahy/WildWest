//
//  DistanceRules.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 15/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public enum DistanceRules {
    
    public static func distance(from player: String, to other: String, in state: StateProtocol) -> Int {
        guard let pIndex = state.playOrder.firstIndex(of: player),
              let oIndex = state.playOrder.firstIndex(of: other),
              pIndex != oIndex else {
            return 0
        }
        
        let count = state.playOrder.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + count - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + count - oIndex)
        var distance = min(rightDistance, leftDistance)
        
        distance -= state.scope(for: player)
        
        distance += state.mustang(for: other)
        
        return distance
    }
}

private extension StateProtocol {
    
    func scope(for player: String) -> Int {
        activeInPlayCards(for: player).compactMap { $0.attributes[.scope] as? Int }.reduce(0, +)
    }
    
    func mustang(for player: String) -> Int {
        activeInPlayCards(for: player).compactMap { $0.attributes[.mustang] as? Int }.reduce(0, +)
    }
    
    func activeInPlayCards(for player: String) -> [CardProtocol] {
        guard let playerObject = players[player] else {
            return []
        }
        
        if turn != player,
           players[turn]?.attributes[.silentInPlay] != nil {
            return [playerObject]
        }
        
        return [playerObject] + playerObject.inPlay
    }
}
