//
//  Challenge+Damage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension Challenge {
    
    init(name: ChallengeName, targetIds: [String] = [], damage: Int? = nil, barrelsResolved: Int = 0) {
        self.name = name
        self.targetIds = targetIds
        self.damage = damage ?? Self.defaultDamage(for: name)
        self.barrelsResolved = barrelsResolved
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
    
    func removing(_ playerId: String) -> Challenge? {
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
    
    func removingOneDamage(for playerId: String) -> Challenge? {
        guard case .dynamiteExploded = name else {
            fatalError("Illegal state")
        }
        
        let remainingDamage = damage - 1
        if remainingDamage == 0 {
            return removing(playerId)
        } else {
            return Challenge(name: name, damage: remainingDamage)
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
    
    func permutingTargets() -> Challenge? {
        guard case .duel = name else {
            return self
        }
        
        let permutedIds = [targetIds[1], targetIds[0]]
        return Challenge(name: name, targetIds: permutedIds)
    }
    
    func actorId(in state: GameStateProtocol) -> String? {
        switch name {
        case .bang, .duel, .gatling, .indians, .generalStore:
            return targetIds.first
            
        case .startTurn, .discardExcessCards, .dynamiteExploded:
            return state.turn
        }
    }
    
    func incrementingBarrelsResolved() -> Challenge {
        Challenge(name: name,
                  targetIds: targetIds,
                  damage: damage,
                  barrelsResolved: barrelsResolved + 1)
    }
    
}
