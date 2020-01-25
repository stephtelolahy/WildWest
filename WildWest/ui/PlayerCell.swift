//
//  PlayerCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet private weak var figureImageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var activeView: UIView!
    
    func update(with player: PlayerProtocol) {
        figureImageView.image = UIImage(named: player.imageName)
        infoLabel.text = player.string
        activeView.isHidden = true
    }
    
    func clear() {
        figureImageView.image = nil
        infoLabel.text = nil
        activeView.isHidden = true
        backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemGreen : .clear
        }
    }
}

private extension PlayerProtocol {
    var string: String {
        return """
        \(health)/\(maxHealth)
        \(role == .sheriff ? role.rawValue : "?")
        x\(hand.cards.count)
        \(inPlay.cards.map { $0.name.rawValue }.joined())
        """
    }
}
