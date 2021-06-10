//
//  GameRolesWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class GameRolesWidget: UIAlertController {
    
    convenience init(playersCount: Int, completion: @escaping () -> Void) {
        let roles = GSetup().roles(for: playersCount)
        let rolesWithCount: [String] = Role.allCases.compactMap { role in
            guard let count = roles.filterOrNil({ $0 == role })?.count else {
                return nil
            }
            return "\(count) \(role.rawValue)"
        }
        let message = rolesWithCount.joined(separator: "\n")
        self.init(title: "Roles", message: message, closeAction: "Start", completion: completion)
    }
}
