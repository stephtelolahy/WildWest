//
//  UIView+Border.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit

extension UIView {
    func addBrownRoundedBorder() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.brown.cgColor
        layer.borderWidth = 4
        clipsToBounds = true
    }
}
