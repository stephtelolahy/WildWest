//
//  GameUpdate+Animatable.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == GameUpdate {
    
    // Split array of GameUpdate into groups that could be animated simultaneously
    func splitAnimatables() -> [[Element]] {
        var array = self
        var result: [[Element]] = []
        while !array.isEmpty {
            var current = [array.remove(at: 0)]
            while (!array.isEmpty && array.first?.isAnimatable == false)
                || (!current.contains(where: { $0.isAnimatable }) && array.first?.isAnimatable == true) {
                current.append(array.remove(at: 0))
            }
            result.append(current)
        }
        return result
    }
}

private extension GameUpdate {
    var isAnimatable: Bool {
        switch self {
        case .setTurn,
             .setChallenge,
             .setupGeneralStore,
             .playerGainHealth,
             .playerLooseHealth:
            return false
            
        default:
            return true
        }
    }
}
