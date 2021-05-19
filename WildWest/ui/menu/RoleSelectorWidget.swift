//
//  RoleSelectorWidget.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class RoleSelectorWidget: UIAlertController {
    
    convenience init(_ completion: @escaping (Role?) -> Void) {
        self.init(title: "Choose role", message: nil, preferredStyle: .alert)
        let roles = Role.allCases
        roles.forEach { role in
            addAction(UIAlertAction(title: role.rawValue,
                                    style: .default,
                                    handler: { _ in
                                        completion(role)
                                        
                                    }))
        }
        
        addAction(UIAlertAction(title: "Random",
                                style: .cancel,
                                handler: { _ in
                                    completion(nil)
                                }))
    }
}
