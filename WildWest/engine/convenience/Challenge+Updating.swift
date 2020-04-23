//
//  Challenge+Updating.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    init(name: MoveName,
         targetIds: [String] = [],
         damage: Int? = nil,
         counterNeeded: Int = 1,
         barrelsPlayed: Int = 0) {
        self.name = name
        self.targetIds = targetIds
        self.damage = damage ?? Self.defaultDamage(for: name)
        self.counterNeeded = counterNeeded
        self.barrelsPlayed = barrelsPlayed
    }
    
    private static func defaultDamage(for name: MoveName) -> Int {
        switch name {
        case .bang, .gatling, .indians, .duel:
            return 1
            
        case .dynamiteExploded:
            return 3
            
        default:
            return 0
        }
    }
}

extension Challenge {
    
    func countering(_ playerId: String) -> Challenge? {
        let remainingCounter = counterNeeded - 1
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
            let remainingIds = targetIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return Challenge(name: name,
                                 targetIds: remainingIds,
                                 damage: damage)
            }
            
        case .duel:
            return nil
            
        case .dynamiteExploded:
            return Challenge(name: .startTurn)
            
        default:
            fatalError("Illegal state")
        }
    }
    
    func decrementingDamage(_ playerId: String) -> Challenge? {
        let remainingDamage = damage - 1
        if remainingDamage <= 0 {
            return removing(playerId)
        } else {
            return Challenge(name: name,
                             targetIds: targetIds,
                             damage: remainingDamage)
        }
    }
    
    func swappingTargets() -> Challenge? {
        guard targetIds.count == 2 else {
            fatalError("Illegal state")
        }
        
        return Challenge(name: name,
                         targetIds: [targetIds[1], targetIds[0]])
    }
    
    func incrementingBarrelsPlayed() -> Challenge {
        Challenge(name: name,
                  targetIds: targetIds,
                  damage: damage,
                  counterNeeded: counterNeeded,
                  barrelsPlayed: barrelsPlayed + 1)
    }
}
