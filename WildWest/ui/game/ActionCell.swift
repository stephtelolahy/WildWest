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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.borderWidth = 4
    }
    
    // MARK: Setup
    
    func update(with item: ActionItem) {
        cardView.alpha = !item.actions.isEmpty ? 1.0 : 0.4
        
        guard let card = item.card else {
            cardImageView.image = #imageLiteral(resourceName: "01_nothing")
            nameLabel.text = nil
            valueLabel.text = "\(item.actions.count)"
            cardView.layer.borderColor = UIColor.brown.cgColor
            return
        }
        
        cardImageView.image = UIImage(named: card.imageName)
        nameLabel.text = card.name.rawValue.uppercased()
        valueLabel.text = "\(card.value)\(card.suit.string)"
        cardView.layer.borderColor = card.name.isBlue ? UIColor.systemBlue.cgColor : UIColor.brown.cgColor
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
