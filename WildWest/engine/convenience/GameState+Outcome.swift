//
//  GameState+Outcome.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func claculateOutcome() -> GameOutcome? {
        let remainingRoles = players.map { $0.role }
        let allOutlawsAreEliminated = remainingRoles.filter { $0 == .outlaw || $0 == .renegade }.isEmpty
        if allOutlawsAreEliminated {
            return .sheriffWin
        }
        
        let sheriffIsEliminated = !remainingRoles.contains(.sheriff)
        if sheriffIsEliminated {
            let lastPlayerIsRenegade = remainingRoles.count == 1 && remainingRoles.first == .renegade
            if lastPlayerIsRenegade {
                return .renegadeWin
            } else {
                return .outlawWin
            }
        }
        
        return nil
    }
}
