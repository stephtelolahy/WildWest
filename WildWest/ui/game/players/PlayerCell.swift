//
//  PlayerCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import Kingfisher

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet private weak var figureImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var equipmentLabel: UILabel!
    @IBOutlet private weak var roleImageView: UIImageView!
    @IBOutlet private weak var healthLabel: UILabel!
    @IBOutlet private weak var handLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        figureImageView.addBrownRoundedBorder()
    }
    
    private var item: PlayerItem?
    
    func update(with item: PlayerItem) {
        self.item = item
        updateBackground()
        
        let player = item.player
        nameLabel.text = "\(player.figureName.rawValue.uppercased())"// \(item.score?.description ?? "")"
        let isEliminated = player.health == 0
        figureImageView.alpha = !isEliminated ? 1.0 : 0.4
        equipmentLabel.text = player.inPlay.map { "[\($0.name.rawValue)]" }.joined(separator: "\n")
        roleImageView.image = item.player.role?.image()
        healthLabel.text = ""
            + Array(player.health..<player.maxHealth).map { _ in "░" }
            + Array(0..<player.health).map { _ in "■" }.joined()
        handLabel.text = "[] \(player.hand.count)"
        figureImageView.image = UIImage(named: player.imageName)
        
        if let user = item.user {
            avatarImageView.kf.setImage(with: URL(string: user.photoUrl))
        } else {
            avatarImageView.image = nil
        }
    }
    
    private func updateBackground() {
        guard let item = self.item else {
            backgroundColor = .clear
            return
        }
        
        if item.player.health == 0 {
            backgroundColor = .clear
        } else if item.isTurn {
            backgroundColor = UIColor.orange
        } else if item.isAttacked {
            backgroundColor = UIColor.red
        } else if item.isHelped {
            backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        } else {
            backgroundColor = UIColor.brown.withAlphaComponent(0.4)
        }
    }
}

extension UIView {
    func addBrownRoundedBorder() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.brown.cgColor
        layer.borderWidth = 4
        clipsToBounds = true
    }
}
