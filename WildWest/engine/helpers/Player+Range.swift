//
//  Player+Range.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
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
}
