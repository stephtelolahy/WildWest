//
//  UserDefaultsStored.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsStored<T> {
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults
    
    init(_ key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    var wrappedValue: T {
        get {
            storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key)
            storage.synchronize()
        }
    }
}
