//
//  ChallengeExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    func removing(_ playerId: String) -> Challenge? {
        switch self {
        case let .shoot(playerIds):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .shoot(remainingIds)
            }
            
        case let .indians(playerIds):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .indians(remainingIds)
            }
            
        case let .generalStore(playerIds):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .generalStore(remainingIds)
            }
            
        default:
            return nil
        }
    }
}
