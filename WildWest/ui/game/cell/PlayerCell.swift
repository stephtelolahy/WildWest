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
    
    func update(with item: PlayerItem) {
        self.item = item
        updateBackground()
        
        let player = item.player
        nameLabel.text = "\(player.figureName.rawValue.uppercased())\n\(item.score?.description ?? "")"
        let isEliminated = player.health == 0
        figureImageView.alpha = !isEliminated ? 1.0 : 0.4
        equipmentLabel.text = player.inPlay.map { "[\($0.name.rawValue)]" }.joined(separator: "\n")
        roleLabel.text = item.player.role?.rawValue ?? ""
        healthLabel.text = ""
            + Array(player.health..<player.maxHealth).map { _ in "░" }
            + Array(0..<player.health).map { _ in "■" }.joined()
        handLabel.text = "[] \(player.hand.count)"
        figureImageView.image = UIImage(named: player.imageName)
    }
    
    private func updateBackground() {
        guard let item = self.item else {
            backgroundColor = .clear
            return
        }
        
        if item.isAttacked {
            backgroundColor = UIColor.red
        } else if item.isHelped {
            backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        } else if item.isTurn {
            backgroundColor = UIColor.orange
        } else {
            backgroundColor = UIColor.brown.withAlphaComponent(0.4)
        }
    }
}
