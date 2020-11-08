//
//  AnalyticsManager.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import CardGameEngine

class AnalyticsManager {
    
    func tageEventPlayerDescriptor(_ player: PlayerProtocol) {
        Analytics.logEvent("player_descriptor",
                           parameters: ["name": player.name])
    }
    
    func tagEventGameOver(_ state: StateProtocol) {
        Analytics.logEvent("game_over",
                           parameters: ["outcome": state.outcomeText,
                                        "winner": state.winnerName,
                                        "players_count": state.players.count])
    }
}

private extension StateProtocol {
    
    var outcomeText: String {
        "\(winner?.rawValue ?? "") wins" 
    }
    
    var winnerName: String {
        players.values.first(where: { $0.role == winner })?.name ?? ""
    }
}
