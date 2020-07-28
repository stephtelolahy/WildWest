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
    
    @UserDefaultsStored("update_delay", defaultValue: 0.8)
    var updateDelay: Double
    
    @UserDefaultsStored("assisted_mode", defaultValue: false)
    var assistedMode: Bool
    
    @UserDefaultsStored("enable_sound", defaultValue: true)
    var enableSound: Bool
}
