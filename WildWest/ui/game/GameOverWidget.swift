//
//  GameOverWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class GameOverWidget: UIAlertController {
    
    convenience init(winner: Role, completion: @escaping () -> Void) {
        self.init(title: "Game Over",
                  message: "\(winner.rawValue) wins",
                  closeAction: "Close",
                  completion: {
                    completion()
                  })
    }
}
