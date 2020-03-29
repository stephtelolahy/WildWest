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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var equipmentLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var healthLabel: UILabel!
    @IBOutlet private weak var handLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        figureImageView.layer.cornerRadius = 8
        figureImageView.layer.borderColor = UIColor.brown.cgColor
        figureImageView.layer.borderWidth = 4
        figureImageView.clipsToBounds = true
    }
    
    private var item: PlayerItem?
    
    func update(with item: PlayerItem?) {
        self.item = item
        updateBackground()
        
        guard let item = item else {
            figureImageView.image = nil
            nameLabel.text = nil
            roleLabel.text = nil
            healthLabel.text = nil
            handLabel.text = nil
            equipmentLabel.text = nil
            figureImageView.alpha = 0.0
            return
        }
        
        let player = item.player
        nameLabel.text = "\(player.figure.ability.rawValue.uppercased())\n\(item.score?.description ?? "")"
        figureImageView.alpha = !item.isEliminated ? 1.0 : 0.4
        equipmentLabel.text = player.inPlay.map { "[\($0.name.rawValue)]" }.joined(separator: "\n")
        if let role = item.player.role {
            roleLabel.text = role.rawValue
        } else {
            roleLabel.text = ""
        }
        healthLabel.text = ""
            + Array(player.health..<player.maxHealth).map { _ in "░" }
            + Array(0..<player.health).map { _ in "■" }.joined()
        handLabel.text = "[] \(player.hand.count)"
        figureImageView.image = UIImage(named: player.figure.imageName)
    }
    
    private func updateBackground() {
        guard let item = self.item else {
            backgroundColor = .clear
            return
        }
        
        if item.isAttacked {
            backgroundColor = UIColor.orange
        } else if item.isHelped {
            backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        } else if item.isTurn {
            backgroundColor = UIColor.green.withAlphaComponent(0.4)
        } else if item.isControlled {
            backgroundColor = UIColor.white.withAlphaComponent(0.4)
        } else {
            backgroundColor = .clear
        }
    }
}
