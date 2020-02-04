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
    
    private var isActive: Bool = false
    
    func update(with item: PlayerItem) {
        guard let player = item.player else {
            figureImageView.image = nil
            infoLabel.text = nil
            backgroundColor = .clear
            return
        }
        
        figureImageView.image = UIImage(named: player.imageName)
        infoLabel.text = player.string
        isActive = item.isActive
        updateBackground()
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackground()
        }
    }
    
    private func updateBackground() {
        if isActive {
            backgroundColor = isSelected ?  .systemYellow : .systemGreen
        } else {
            backgroundColor = isSelected ? .systemYellow : .clear
        }
        
    }
}

private extension PlayerProtocol {
    var string: String {
        return """
        \(health)/\(maxHealth)
        \(role == .sheriff ? role.rawValue : "?")
        x\(hand.count)
        \(inPlay.map { $0.name.rawValue }.joined(separator: "\n"))
        """
    }
}
