//
//  MessageCell.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 2/25/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, MoveDescriptor {
    
    @IBOutlet private weak var messageLabel: UILabel!
    
    func update(with move: GameMove) {
        messageLabel.text = description(for: move)
    }
}
