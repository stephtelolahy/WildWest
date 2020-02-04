//
//  GenericActionCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class GenericActionCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: Setup
    
    func update(with action: GenericAction) {
        guard let cardId = action.cardId else {
            cardImageView.image = nil
            infoLabel.text = action.name
            return
        }
        
        //cardImageView.image = UIImage(named: card.imageName)
        //infoLabel.text = "\(card.value) \(card.suit.string)"
        infoLabel.text = cardId
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
