//
//  UserPreferences.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable let_var_whitespace
import WildWestEngine

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
    
    @UserDefaultsStored("enable_sound", defaultValue: true)
    var enableSound: Bool
    
    @UserDefaultsStored("assisted_mode", defaultValue: true)
    var assistedMode: Bool
    
}
