//
//  UIViewExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

extension UIView {
    
    func addCardShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 1.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
    }
}
