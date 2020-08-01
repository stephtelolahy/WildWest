//
//  RoleSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import Resolver

class RoleSelector: UIAlertController {
    
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    convenience init(completion: @escaping (Role?) -> Void) {
        self.init(title: "Choose role", message: nil, preferredStyle: .alert)
        let roles = Role.allCases
        roles.forEach { role in
            addAction(UIAlertAction(title: role.rawValue,
                                    style: .default,
                                    handler: { _ in
                                        self.preferences.preferredRole = role
                                        completion(role)
                                        
            }))
        }
        
        addAction(UIAlertAction(title: "Random",
                                style: .cancel,
                                handler: { _ in
                                    self.preferences.preferredRole = nil
                                    completion(nil)
        }))
    }
}
