//
//  Player+Range.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension PlayerProtocol {
    
    func bangLimitsPerTurn() -> Int {
        if inPlay.contains(where: { $0.name == .volcanic }) {
            return 0
        } else {
            return 1
        }
    }
}
