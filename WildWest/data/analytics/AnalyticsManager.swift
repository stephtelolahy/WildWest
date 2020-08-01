//
//  AnalyticsManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

class AnalyticsManager {
    
    func tagEventGameOver(_ state: GameStateProtocol) {
        Analytics.logEvent("game_over", parameters: [
            "outcome": state.outcomeText ?? "",
            "winner": state.winner ?? "",
            "players_count": state.allPlayers.count
        ])
    }
}

private extension GameStateProtocol {
    
    var outcomeText: String? {
        guard let outcome = self.outcome else {
            return nil
        }
        
        return outcome.rawValue
    }
    
    var winner: String? {
        guard let outcome = self.outcome else {
            return nil
        }
        
        switch outcome {
        case .sheriffWin:
            return players.first(where: { $0.role == .sheriff })?.figureName.rawValue
            
        case .renegadeWin:
            return players.first(where: { $0.role == .renegade })?.figureName.rawValue
            
        case .outlawWin:
            return players.first(where: { $0.role == .outlaw })?.figureName.rawValue
        }
    }
}
