//
//  GameMove+Grouping.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == GameMove {
    
    func groupedByActor() -> [String: [GameMove]] {
        var grouped: [String: [GameMove]] = [:]
        for move in self {
            if grouped[move.actorId] != nil {
                grouped[move.actorId]!.append(move)
            } else {
                grouped[move.actorId] = [move]
            }
        }
        
        return grouped
    }
}
