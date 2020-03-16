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
        case let .shoot(playerIds, cardName, source):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .shoot(remainingIds, cardName, source)
            }
            
        case let .indians(playerIds, source):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .indians(remainingIds, source)
            }
            
        case let .generalStore(playerIds):
            let remainingIds = playerIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return .generalStore(remainingIds)
            }
            
        case .startTurnDynamiteExploded:
            return .startTurn
            
        default:
            return nil
        }
    }
    
    var damageSource: DamageSource? {
        switch self {
        case let .shoot(_, _, sourceId):
            return .byPlayer(sourceId)
            
        case let .duel(_, sourceId):
            return .byPlayer(sourceId)
            
        case let .indians(_, sourceId):
            return .byPlayer(sourceId)
            
        case .startTurnDynamiteExploded:
            return .byDynamite
            
        default:
            return nil
        }
    }
}
