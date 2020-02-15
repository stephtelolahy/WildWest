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
    
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: Setup
    
    func update(with item: ActionItem) {
        if let card = item.card {
            cardImageView.image = UIImage(named: card.imageName)
            infoLabel.text = "\(card.value) \(card.suit.string)"
        } else {
            cardImageView.image = nil
            infoLabel.text = "other"
        }
        
        cardImageView.alpha = !item.actions.isEmpty ? 1.0 : 0.4
    }
}

private extension CardSuit {
    var string: String {
        switch self {
        case .spades:
            return "♠"
        case .hearts:
            return "♥"
        case .diamonds:
            return "♦"
        case .clubs:
            return "♣"
        }
    }
}
