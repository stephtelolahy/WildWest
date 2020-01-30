//
//  CardCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        cardImageView.addCardShadow()
    }
    
    // MARK: Setup
    
    func update(with card: CardProtocol) {
        cardImageView.image = UIImage(named: card.imageName)
        infoLabel.text = "\(card.value) \(card.suit.string)"
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
