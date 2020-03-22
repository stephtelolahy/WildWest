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
        let components: [String] = [
            move.actorId,
            move.name.rawValue,
            move.cardName?.rawValue,
            move.targetId,
            move.targetCard?.description
            ]
            .compactMap { $0 }
        
        return "\(emoji(matching: components)) \(components.joined(separator: " "))"
    }
    
    private func emoji(matching components: [String]) -> String {
        for component in components {
            let filtered = emojis.filter { component.lowercased().contains($0.key.lowercased()) }
            if let match = filtered.first {
                return match.value
            }
        }
        fatalError("No matching emoji found")
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
