//
//  Challenge+Damage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    init(name: ChallengeName,
         targetIds: [String] = [],
         damage: Int? = nil,
         counterNeeded: Int = 1,
         barrelsResolved: Int = 0) {
        self.name = name
        self.targetIds = targetIds
        self.damage = damage ?? Self.defaultDamage(for: name)
        self.counterNeeded = counterNeeded
        self.barrelsPlayed = barrelsResolved
    }
    
    private static func defaultDamage(for name: ChallengeName) -> Int {
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

// Custom Getters
extension Challenge {
    
    func actorId(in state: GameStateProtocol) -> String? {
        switch name {
        case .bang, .duel, .gatling, .indians, .generalStore:
            return targetIds.first
            
        case .startTurn, .discardExcessCards, .dynamiteExploded:
            return state.turn
        }
    }
    
    func damageSource(in state: GameStateProtocol) -> DamageSource? {
        switch name {
        case .bang, .gatling, .duel, .indians:
            return .byPlayer(state.turn)
            
        case .dynamiteExploded:
            return .byDynamite
            
        default:
            fatalError("Illegal state")
        }
    }
}

// Custom Updaters
extension Challenge {
    
    func countering(for playerId: String) -> Challenge? {
        let remainingCounter = counterNeeded - 1
        if remainingCounter <= 0 {
            return removing(playerId)
        } else {
            return Challenge(name: name, targetIds: targetIds, counterNeeded: remainingCounter)
        }
    }
    
    func removing(_ playerId: String? = nil) -> Challenge? {
        switch name {
        case .bang, .gatling, .indians, .generalStore:
            let remainingIds = targetIds.filter { $0 != playerId }
            if remainingIds.isEmpty {
                return nil
            } else {
                return Challenge(name: name, targetIds: remainingIds)
            }
            
        case .duel:
            return nil
            
        case .dynamiteExploded:
            return Challenge(name: .startTurn)
            
        default:
            fatalError("Illegal state")
        }
    }
    
    func decrementingDamage() -> Challenge? {
        guard case .dynamiteExploded = name else {
            fatalError("Illegal state")
        }
        
        let remainingDamage = damage - 1
        if remainingDamage <= 0 {
            return removing()
        } else {
            return Challenge(name: name, damage: remainingDamage)
        }
    }
    
    func swappingDuel() -> Challenge? {
        guard case .duel = name else {
            fatalError("Illegal state")
        }
        
        let permutedIds = [targetIds[1], targetIds[0]]
        return Challenge(name: name, targetIds: permutedIds)
    }
    
    func incrementingBarrelsPlayed() -> Challenge {
        Challenge(name: name,
                  targetIds: targetIds,
                  damage: damage,
                  counterNeeded: counterNeeded,
                  barrelsPlayed: barrelsPlayed + 1)
    }
}
