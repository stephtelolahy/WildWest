//
//  GameState+DiscardImage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/08/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import CardGameEngine

extension StateProtocol {
    
    var topDiscardImage: UIImage? {
        guard let topDiscard = discard.first else {
            return UIImage(color: .gold)
        }
        
        return UIImage(named: topDiscard.name)
    }
}
