//
//  UserPreferences.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable let_var_whitespace
import CardGameEngine

protocol UserPreferencesProtocol {
    var playersCount: Int { get set }
    var preferredRole: Role? { get set }
    var preferredFigure: String? { get set }
    var updateDelay: Double { get }
    var assistedMode: Bool { get }
    var enableSound: Bool { get }
}

class UserPreferences: UserPreferencesProtocol {
    
    @UserDefaultsStored("players_count", defaultValue: 5)
    var playersCount: Int
    
    @OptionalEnumUserDefaultsStored("preferred_role")
    var preferredRole: Role?
    
    @OptionalUserDefaultsStored("preferred_figure")
    var preferredFigure: String?
    
    @UserDefaultsStored("update_delay", defaultValue: 0.4)
    var updateDelay: Double
    
    @UserDefaultsStored("assisted_mode", defaultValue: false)
    var assistedMode: Bool
    
    @UserDefaultsStored("enable_sound", defaultValue: true)
    var enableSound: Bool
}
