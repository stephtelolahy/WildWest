//
//  OutcomeCalculator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 14/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class OutcomeCalculator: OutcomeCalculatorProtocol {
    func outcome(for remainingRoles: [Role]) -> GameOutcome? {
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
