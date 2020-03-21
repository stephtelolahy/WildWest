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
            "EndTurn": "✔️",
            "Equip": "😎",
            "Gatling": "🔫",
            "GeneralStore": "💰",
            "Indians": "💢",
            "Jail": "🚧",
            "LooseLife": "❤️",
            "Missed": "😝",
            "Panic": "‼️",
            "Dynamite": "💣",
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
            //  ❗️❌ 💥 🎖🏆 🏜 🍻
        ]
    }
}
