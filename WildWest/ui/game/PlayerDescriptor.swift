//
//  PlayerDescriptor.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class PlayerDescriptor: UIAlertController {
    
    convenience init(player: PlayerProtocol) {
        self.init(title: player.figureName.rawValue.uppercased(),
                  message: player.description,
                  preferredStyle: .alert)
        
        addAction(UIAlertAction(title: "Close",
                                style: .cancel,
                                handler: nil))
    }
}
