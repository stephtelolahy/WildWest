//
//  Player+Ability.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension PlayerProtocol {
    
    var bangLimitsPerTurn: Int {
        if figure.abilities[.hasNoLimitOnBangsPerTurn] == true {
            return 0
        }
        
        if inPlay.contains(where: { $0.name == .volcanic }) {
            return 0
        }
        
        return 1
    }
    
    var gunRange: Int {
        guard let weapon = inPlay.first(where: { $0.name.isGun }) else {
            return 1
        }
        
        return weapon.name.range
    }
    
    var scopeCount: Int {
        var result = 0
        
        if inPlay.contains(where: { $0.name == .scope }) {
            result += 1
        }
        
        if figure.abilities[.hasScopeAllTimes] == true {
            result += 1
        }
        
        return result
    }
    
    var mustangCount: Int {
        var result = 0
        
        if inPlay.contains(where: { $0.name == .mustang }) {
            result += 1
        }
        
        if figure.abilities[.hasMustangAllTimes] == true {
            result += 1
        }
        
        return result
    }
    
    var barrelsCount: Int {
        var result = 0
        
        if inPlay.contains(where: { $0.name == .barrel }) {
            result += 1
        }
        
        if figure.abilities[.hasBarrelAllTimes] == true {
            result += 1
        }
        
        return result
    }
}
