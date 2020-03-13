//
//  MessageCell.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 2/25/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet private weak var messageLabel: UILabel!
    
    func update(with action: ActionProtocol) {
        messageLabel.text = "\(emoji(for: action)) \(action.description)"
    }
}

private extension MessageCell {
    
    var emojis: [String: String] {
        [
            "Bang": "🔫",
            "Beer": "🍺",
            "CatBalou": "‼️",
            "ChooseCard": "💰",
            "DiscardBang": "🔫",
            "DiscardBeer": "😝",
            "Duel": "🔫",
            "Eliminate": "☠️",
            "EndTurn": "❌",
            "Equip": "😎",
            "Gatling": "🔫",
            "GeneralStore": "💰",
            "Indians": "💢",
            "Jail": "🚧",
            "LooseLife": "❤️",
            "Missed": "😝",
            "Panic": "‼️",
            "ResolveBarrel": "❔",
            "ResolveDynamite": "❔",
            "ResolveJail": "❔",
            "Saloon": "🍺",
            "Stagecoach": "💰",
            "StartTurn": "🔥",
            "WellsFargo": "💰",
            "DiscardAllSheriffCardsOnEliminateDeputy": "⚠️",
            "RewardOneWhoEliminatesOutlaw": "🎁",
            "SetOutComeOnGameOver": "🎉"
        ]
    }
    
    func emoji(for action: ActionProtocol) -> String {
        
        guard let className = String(describing: action).split(separator: "(").first,
            let emoji = emojis[String(className)] else {
            return ""
        }
        return emoji
    }
}
