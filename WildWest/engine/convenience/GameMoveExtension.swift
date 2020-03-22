//
//  GameMoveExtension.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Array where Element == GameMove {
    
    func groupedByActor() -> [String: [GameMove]] {
        var grouped: [String: [GameMove]] = [:]
        for move in self {
            guard let actorId = move.actorId else {
                continue
            }
            
            if grouped[actorId] != nil {
                grouped[actorId]!.append(move)
            } else {
                grouped[actorId] = [move]
            }
        }
        
        return grouped
    }
}
