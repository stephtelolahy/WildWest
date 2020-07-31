//
//  RoleSelector.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class RoleSelector: UIAlertController {
    
    private lazy var preferences = AppModules.shared.userPreferences
    private lazy var roles = Role.allCases
    
    convenience init(completion: @escaping (Role?) -> Void) {
        self.init(title: "Choose role", message: nil, preferredStyle: .alert)
        roles.forEach { role in
            self.addAction(UIAlertAction(title: role.rawValue,
                                         style: .default,
                                         handler: { _ in
                                            self.preferences.preferredRole = role
                                            completion(role)
                                            
            }))
        }
        
        self.addAction(UIAlertAction(title: "Random",
                                     style: .cancel,
                                     handler: { _ in
                                        self.preferences.preferredRole = nil
                                        completion(nil)
        }))
    }
}
