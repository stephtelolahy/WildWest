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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var equipmentLabel: UILabel!
    
    private var item: PlayerItem?
    
    func update(with item: PlayerItem) {
        self.item = item
        updateBackground()
        
        guard let player = item.player else {
            figureImageView.image = nil
            nameLabel.text = nil
            infoLabel.text = nil
            equipmentLabel.text = nil
            figureImageView.alpha = 0.0
            return
        }
        
        nameLabel.text = player.ability.rawValue.uppercased()
        figureImageView.alpha = !item.isEliminated ? 1.0 : 0.4
        equipmentLabel.text = player.inPlay.map { "[\($0.name.rawValue)]" }.joined(separator: "\n")
        infoLabel.text = player.infoText(when: item.isEliminated)
        figureImageView.image = UIImage(named: player.imageName)
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackground()
        }
    }
    
    private func updateBackground() {
        guard let item = self.item,
            item.player != nil else {
                backgroundColor = .clear
                return
        }
        
        if isSelected {
            backgroundColor = .systemYellow
        } else if item.isTurn {
            backgroundColor = .systemOrange
        } else if item.isActive {
            backgroundColor = .systemGreen
        } else {
            backgroundColor = .clear
        }
    }
}

private extension PlayerProtocol {
    func infoText(when eliminated: Bool) -> String {
        let healthString = Array(0..<health).map { _ in "▓" }.joined()
        let roleString = eliminated ? role.rawValue : (role == .sheriff ? role.rawValue : "?")
        let handString = "[] \(hand.count)"
        return """
        \(roleString)
        \(healthString)
        \(handString)
        """
    }
}
