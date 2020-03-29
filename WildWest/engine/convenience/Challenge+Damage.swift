//
//  Challenge+Damage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    var damage: Int {
        switch name {
        case .bang, .gatling, .indians, .duel:
            return 1
            
        case .dynamiteExploded:
            return 3
            
        default:
            fatalError("Illegal state")
        }
    }
    
    func removing(_ playerId: String) -> Challenge? {
        switch name {
        case .bang, .gatling, .indians, .generalStore:
            let remainingIds = targetIds?.filter { $0 != playerId } ?? []
            if remainingIds.isEmpty {
                return nil
            } else {
                return Challenge(name: name, actorId: actorId, targetIds: remainingIds)
            }
            
        case .duel:
            return nil
            
        case .dynamiteExploded:
            return Challenge(name: .startTurn)
            
        default:
            fatalError("Illegal state")
        }
    }
    
    var damageSource: DamageSource? {
        switch name {
        case .bang, .gatling, .duel, .indians:
            return .byPlayer(actorId!)
            
        case .dynamiteExploded:
            return .byDynamite
            
        default:
            fatalError("Illegal state")
        }
    }
    
    func permutingTargets() -> Challenge? {
        guard case .duel = name,
            let targetIds = self.targetIds else {
                return self
        }
        
        let permutedIds = [targetIds[1], targetIds[0]]
        return Challenge(name: name, actorId: actorId, targetIds: permutedIds)
    }
}
