//
//  PlayerCell.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine
import Kingfisher

struct PlayerItem {
    let player: PlayerProtocol
    let isTurn: Bool
    let isHit: Bool
    let user: UserInfo?
}

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
    
    func update(with item: PlayerItem) {
        updateBackground(item)
        
        let player = item.player
        nameLabel.text = player.name.uppercased()
        let isEliminated = player.health == 0
        figureImageView.alpha = !isEliminated ? 1.0 : 0.4
        equipmentLabel.text = player.inPlay.map { "[\($0.name)]" }.joined(separator: "\n")
        if let role = player.role {
            roleImageView.image = UIImage(named: role.rawValue)
        } else {
            roleImageView.image = nil
        }
        healthLabel.text = ""
            + Array(player.health..<player.maxHealth).map { _ in "░" }
            + Array(0..<player.health).map { _ in "■" }.joined()
        handLabel.text = "[] \(player.hand.count)"
        figureImageView.image = UIImage(named: player.name)
        
        if let user = item.user {
            avatarImageView.kf.setImage(with: URL(string: user.photoUrl))
        } else {
            avatarImageView.image = nil
        }
    }
    
    private func updateBackground(_ item: PlayerItem) {
        if item.player.health == 0 {
            backgroundColor = .clear
        } else if item.isHit {
            backgroundColor = UIColor.red
        } else if item.isTurn {
            backgroundColor = UIColor.orange
        } else {
            backgroundColor = UIColor.brown.withAlphaComponent(0.4)
        }
    }
}
