//
//  Challenge+Updating.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    func countering(_ playerId: String) -> Challenge? {
        let remainingCounter = (counterNeeded ?? 0) - 1
        if remainingCounter <= 0 {
            return removing(playerId)
        } else {
            return Challenge(name: name,
                             targetIds: targetIds,
                             damage: damage,
                             counterNeeded: remainingCounter,
                             barrelsPlayed: barrelsPlayed)
        }
    }
    
    func removing(_ playerId: String) -> Challenge? {
        switch name {
        case .bang, .gatling, .indians, .generalStore:
            guard let targetIds = self.targetIds,
                let remainingIds = targetIds.filterOrNil({ $0 != playerId }) else {
                    return nil
            }
            
            return Challenge(name: name,
                             targetIds: remainingIds,
                             damage: damage)
            
        case .duel:
            return nil
            
        case .dynamiteExploded:
            return Challenge(name: .startTurn)
            
        default:
            fatalError("Illegal state")
        }
    }
    
    func decrementingDamage(_ playerId: String) -> Challenge? {
        let remainingDamage = (damage ?? 0) - 1
        if remainingDamage <= 0 {
            return removing(playerId)
        } else {
            return Challenge(name: name,
                             targetIds: targetIds,
                             damage: remainingDamage)
        }
    }
    
    func swappingTargets() -> Challenge? {
        guard let targetIds = self.targetIds,
            targetIds.count == 2 else {
                fatalError("Illegal state")
        }
        
        return Challenge(name: name,
                         targetIds: [targetIds[1], targetIds[0]],
                         damage: damage)
    }
    
    func incrementingBarrelsPlayed() -> Challenge {
        Challenge(name: name,
                  targetIds: targetIds,
                  damage: damage,
                  counterNeeded: counterNeeded,
                  barrelsPlayed: (barrelsPlayed ?? 0) + 1)
    }
}
