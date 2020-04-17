//
//  UserPreferences.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable let_var_whitespace

class UserPreferences {
    
    @UserDefaultsStored("preferred_figure", defaultValue: "suzyLafayette")
    var preferredFigure: String
    
    @UserDefaultsStored("players_count", defaultValue: 5)
    var playersCount: Int
    
    @UserDefaultsStored("play_as_sheriff", defaultValue: true)
    var playAsSheriff: Bool
    
    @UserDefaultsStored("update_delay", defaultValue: 0.6)
    var updateDelay: Double
    
    @UserDefaultsStored("assisted_mode", defaultValue: true)
    var assistedMode: Bool
    
    @UserDefaultsStored("simulation_mode", defaultValue: false)
    var simulationMode: Bool
}

extension UserPreferences {
    static let shared = UserPreferences()
}
