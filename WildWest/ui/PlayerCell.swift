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
    
    private var isTurn: Bool = false
    
    func update(with player: PlayerProtocol, isTurn: Bool) {
        figureImageView.image = UIImage(named: player.imageName)
        infoLabel.text = player.string
        self.isTurn = isTurn
        updateBackground()
    }
    
    func clear() {
        figureImageView.image = nil
        infoLabel.text = nil
        backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackground()
        }
    }
    
    private func updateBackground() {
        if isTurn {
            backgroundColor = isSelected ? .systemGreen : .systemYellow
        } else {
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
        \(inPlay.cards.map { $0.name.rawValue }.joined(separator: "\n"))
        """
    }
}
