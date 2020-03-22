//
//  MoveDescriptor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveDescriptor {
    func description(for move: GameMove) -> String?
}

extension MoveDescriptor {
    func description(for move: GameMove) -> String? {
        let components: [String?] = [
            move.actorId,
            move.name.rawValue,
            move.cardName?.rawValue,
            move.targetId,
            move.targetCard?.description
        ]
        let text = components.compactMap { $0 }.joined(separator: " ")
        
        guard let emoji = emojis.first(where: { text.lowercased().contains($0.key.lowercased()) }) else {
            fatalError("No matching emoji found")
        }
        
        return "\(emoji.value) \(text)"
    }
    
    private var emojis: [String: String] {
        [
            "Discard": "😝",
            "Bang": "🔫",
            "Beer": "🍺",
            "CatBalou": "❌",
            "Choose": "💰",
            "Duel": "🔫",
            "EndTurn": "✔️",
            "Gatling": "🔫",
            "volcanic": "😎",
            "schofield": "😎",
            "remington": "😎",
            "winchester": "😎",
            "revCarbine": "😎",
            "barrel": "😎",
            "mustang": "😎",
            "scope": "😎",
            "GeneralStore": "💰",
            "Indians": "💢",
            "Jail": "🚧",
            "pass": "❤️",
            "Missed": "😝",
            "Panic": "‼️",
            "Dynamite": "💣",
            "Resolve": "❔",
            "Saloon": "🍻",
            "Stagecoach": "💰",
            "StartTurn": "🔥",
            "WellsFargo": "💰",
            "Eliminate": "☠️",
            "Reward": "🎁",
            "Penalize": "⚠️"
        ]
    }
}
