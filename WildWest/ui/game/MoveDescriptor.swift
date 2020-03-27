//
//  MoveDescriptor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

protocol MoveDescriptorProtocol {
    func description(for move: GameMove) -> String
}

class MoveDescriptor: MoveDescriptorProtocol {
    func description(for move: GameMove) -> String {
        let components = move.asComponents()
        return "\(emojis.value(matching: components)) \(components.joined(separator: " "))"
    }
    
    private let emojis: [String: String] =
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
            "Penalize": "⚠️",
            "stayInJail": "😞",
            "escapeFromJail": "😅",
            "useBarrel": "😝",
            "failBarrel": "😞",
            "explodeDynamite": "💥",
            "passDynamite": "💣"
        ]
}