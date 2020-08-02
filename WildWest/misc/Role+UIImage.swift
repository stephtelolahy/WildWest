//
//  Role+UIImage.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 31/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension Role {
    func image() -> UIImage {
        switch self {
        case .sheriff:
            return #imageLiteral(resourceName: "01_sceriffo")
        case .outlaw:
            return #imageLiteral(resourceName: "01_fuorilegge")
        case .renegade:
            return #imageLiteral(resourceName: "01_rinnegato")
        case .deputy:
            return #imageLiteral(resourceName: "01_vice")
        }
    }
}
