//
//  Player+Ability.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension PlayerProtocol {
    
    var bangLimitsPerTurn: Int {
        if ability == .willyTheKid {
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
        
        if ability == .roseDoolan {
            result += 1
        }
        
        return result
    }
    
    var mustangCount: Int {
        var result = 0
        
        if inPlay.contains(where: { $0.name == .mustang }) {
            result += 1
        }
        
        if ability == .paulRegret {
            result += 1
        }
        
        return result
    }
    
    var barrelsCount: Int {
        0
    }
}
