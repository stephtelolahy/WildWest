//
//  Challenge+Damage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    var damage: Int {
        switch self {
        case .shoot:
            return 1
            
        case .indians:
            return 1
            
        case .duel:
            return 1
            
        case .dynamiteExploded:
            return 3
            
        default:
            fatalError("Illegal state")
        }
    }
    
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
            
        case .dynamiteExploded:
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
            
        case .dynamiteExploded:
            return .byDynamite
            
        default:
            fatalError("Illegal state")
        }
    }
}
