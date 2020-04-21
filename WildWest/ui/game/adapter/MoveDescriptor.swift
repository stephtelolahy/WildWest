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
        "\(emojis.value(matching: move)) \(move.asComponents().joined(separator: " "))"
    }
    
    private let emojis: [String: String] =
        [
            "Bang": "🔫",
            "Beer": "🍺",
            "discard2CardsFor1Life": "🍺",
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
            "Missed": "😝",
            "Panic": "‼️",
            "Dynamite": "💣",
            "Resolve": "❔",
            "Saloon": "🍻",
            "Stagecoach": "💰",
            "StartTurn": "🔥",
            "WellsFargo": "💰",
            "Eliminate": "☠️",
            "gainRewardOnEliminatingOutlaw": "🎁",
            "Penalize": "⚠️",
            "stayInJail": "😞",
            "escapeFromJail": "😅",
            "useBarrel": "😝",
            "failBarrel": "😞",
            "dynamiteExploded": "💥",
            "passDynamite": "💣",
            "drawsCardOnLoseHealth": "💰",
            "drawsCardFromPlayerDamagedHim": "‼️",
            "drawsCardWhenHandIsEmpty": "💰",
            "drawsAnotherCardIfSecondDrawIsRedSuit": "💰",
            "discardExcessCards": "❌",
            "pass": "❤️"
        ]
}
