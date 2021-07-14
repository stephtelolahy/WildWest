//
//  StateProtocol+Extensions.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 13/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public extension StateProtocol {
    
    func distance(from player: String, to other: String) -> Int {
        guard let pIndex = playOrder.firstIndex(of: player),
              let oIndex = playOrder.firstIndex(of: other),
              pIndex != oIndex else {
            return 0
        }
        
        let count = playOrder.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + count - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + count - oIndex)
        var distance = min(rightDistance, leftDistance)
        
        distance -= scope(for: player)
        
        distance += mustang(for: other)
        
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
