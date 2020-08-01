//
//  UserPreferences.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable let_var_whitespace

protocol UserPreferencesProtocol {
    var playersCount: Int { get set }
    var preferredRole: Role? { get set }
    var preferredFigure: FigureName? { get set }
    var updateDelay: Double { get }
    var assistedMode: Bool { get }
    var enableSound: Bool { get }
}

class UserPreferences: UserPreferencesProtocol {
    
    @UserDefaultsStored("players_count", defaultValue: 5)
    var playersCount: Int
    
    var preferredRole: Role? {
        get {
            Role(rawValue: preferredRoleString)
        }
        set {
            preferredRoleString = newValue?.rawValue ?? ""
        }
    }
    
    @UserDefaultsStored("preferred_role", defaultValue: Role.sheriff.rawValue)
    private var preferredRoleString: String
    
    var preferredFigure: FigureName? {
        get {
            FigureName(rawValue: preferredFigureString)
        }
        set {
            preferredFigureString = newValue?.rawValue ?? ""
        }
    }
    
    @UserDefaultsStored("preferred_figure", defaultValue: FigureName.suzyLafayette.rawValue)
    private var preferredFigureString: String
    
    @UserDefaultsStored("update_delay", defaultValue: 0.8)
    var updateDelay: Double
    
    @UserDefaultsStored("assisted_mode", defaultValue: false)
    var assistedMode: Bool
    
    @UserDefaultsStored("enable_sound", defaultValue: true)
    var enableSound: Bool
}
