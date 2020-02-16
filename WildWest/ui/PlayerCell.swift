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
    
    private var item: PlayerItem?
    
    func update(with item: PlayerItem) {
        self.item = item
        
        guard let player = item.player else {
            figureImageView.image = nil
            infoLabel.text = nil
            backgroundColor = .clear
            return
        }
        
        figureImageView.image = UIImage(named: player.imageName)
        infoLabel.text = player.string
        updateBackground()
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
        
        if item.isTurn {
            backgroundColor = .systemOrange
            return
        }
        
        if isSelected {
            backgroundColor = .systemYellow
            return
        }
        
        if item.isActive {
            backgroundColor = .systemGreen
            return
        }
        
        backgroundColor = .clear
    }
}

private extension PlayerProtocol {
    var string: String {
        let healthString = Array(0..<health).map { _ in "▓" }.joined()
        return """
        \(healthString)/\(maxHealth)
        \(role == .sheriff ? role.rawValue : "?")
        [] \(hand.count)
        \(inPlay.map { $0.name.rawValue }.joined(separator: "\n"))
        """
    }
}
