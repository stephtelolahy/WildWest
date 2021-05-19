//
//  HandCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

class HandCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var cardImageView: UIImageView!
    
    // MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 2
    }
    
    func update(with card: CardProtocol, active: Bool) {
        cardImageView.image = UIImage(named: card.name)
        cardView.isHidden = active
    }
}
