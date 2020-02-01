//
//  RangeCalculator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct RangeCalculator: RangeCalculatorProtocol {
    
    func distance(from playerId: String, to otherId: String, in state: GameStateProtocol) -> Int {
        guard let pIndex = state.players.firstIndex(where: { $0.identifier == playerId }),
            let oIndex = state.players.firstIndex(where: { $0.identifier == otherId }),
            pIndex != oIndex else {
                return 0
        }
        
        let count = state.players.count
        let rightDistance = (oIndex > pIndex) ? (oIndex - pIndex) : (oIndex + count - pIndex)
        let leftDistance = (pIndex > oIndex) ? (pIndex - oIndex) : (pIndex + count - oIndex)
        var distance = min(rightDistance, leftDistance)
        
        if state.players[pIndex].inPlay.contains(where: { $0.name == .scope }) {
            distance -= 1
        }
        
        if state.players[oIndex].inPlay.contains(where: { $0.name == .mustang }) {
            distance += 1
        }
        
        return distance
    }
}
