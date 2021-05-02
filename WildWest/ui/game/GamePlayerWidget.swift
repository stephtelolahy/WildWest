//
//  GamePlayerWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class GamePlayerWidget: UIAlertController {
    
    convenience init(player: PlayerProtocol) {
        self.init(title: player.name.uppercased(), message: player.desc, closeAction: "Close")
    }
}
