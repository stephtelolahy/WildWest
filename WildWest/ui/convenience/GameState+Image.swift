//
//  GameState+Image.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 14/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension GameStateProtocol {
    
    var topDiscardImage: UIImage? {
        guard let topDiscard = discardPile.first else {
            return UIImage(color: .gold)
        }
        
        return UIImage(named: topDiscard.imageName)
    }
}
