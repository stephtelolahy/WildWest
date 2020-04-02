//
//  UserPreferences.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable let_var_whitespace

class UserPreferences {
    
    @UserDefaultsStored("preferred_figure", defaultValue: "")
    var preferredFigure: String
    
    @UserDefaultsStored("players_count", defaultValue: 5)
    var playersCount: Int
    
    @UserDefaultsStored("play_as_sheriff", defaultValue: true)
    var playAsSheriff: Bool
}
