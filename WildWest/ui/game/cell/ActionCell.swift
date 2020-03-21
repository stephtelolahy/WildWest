//
//  ActionCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class ActionCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var cardImageView: UIImageView!
    
    // MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
    }
    
    func update(with item: ActionItem) {
        cardView.isHidden = !item.actions.isEmpty
        
        guard let card = item.card else {
            if let move = item.actions.first {
                switch move.name {
                case .choose:
                    cardImageView.image = #imageLiteral(resourceName: "01_choose_card")
                    
                case .endTurn:
                    cardImageView.image = #imageLiteral(resourceName: "01_end_turn")
                    
                case .pass:
                    cardImageView.image = #imageLiteral(resourceName: "01_nothing")
                    
                default:
                    cardImageView.image = #imageLiteral(resourceName: "01_more")
                }
            }
            return
        }
        
        cardImageView.image = UIImage(named: card.imageName)
    }
}
