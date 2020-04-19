//
//  GameUpdate+Animatable.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == GameUpdate {
    
    func splitByExecutionTime() -> [[Element]] {
        var result: [[Element]] = []
        var current: [Element] = []
        
        for update in self {
            if current.executionTime == 0 || update.executionTime == 0 {
                current.append(update)
            } else {
                result.append(current)
                current = [update]
            }
        }
        
        if !current.isEmpty {
            result.append(current)
        }
        
        return result
    }
    
    private var executionTime: Int {
        reduce(0) { $0 + $1.executionTime }
    }
    
}

private extension GameUpdate {
    var executionTime: Int {
        switch self {
        case .setTurn,
             .setChallenge,
             .setupGeneralStore,
             .playerGainHealth,
             .playerLooseHealth:
            return 0
            
        default:
            return 1
        }
    }
}
