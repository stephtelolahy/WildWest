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
            /*
            if (item.actions.first as? ChooseCard) != nil {
                cardImageView.image = #imageLiteral(resourceName: "01_choose_card")
            } else if (item.actions.first as? EndTurn) != nil {
                cardImageView.image = #imageLiteral(resourceName: "01_end_turn")
            } else if (item.actions.first as? LooseLife) != nil {
                cardImageView.image = #imageLiteral(resourceName: "01_nothing")
            } else {
                cardImageView.image = #imageLiteral(resourceName: "01_more") // use barrel, discard beer
            }
            */
            return
        }
        
        cardImageView.image = UIImage(named: card.imageName)
    }
}

private extension CardName {
    var isBlue: Bool {
        let blueCards: [CardName]  = [
            .volcanic,
            .schofield,
            .remington,
            .winchester,
            .revCarbine,
            .barrel,
            .mustang,
            .scope,
            .dynamite,
            .jail]
        return blueCards.contains(self)
    }
}
