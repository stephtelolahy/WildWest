//
//  MessageAdapter.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import CardGameEngine

protocol MessageAdapterProtocol {
    func description(for move: GMove) -> String
}

class MessageAdapter: MessageAdapterProtocol {
    
    func description(for move: GMove) -> String {
        "\(emojis[move.name] ?? "❓") \(move.actor) \(move.name) \(move.argsString)"
    }
    
    private let emojis: [String: String] =
        [
            "beer": "🍺",
            "saloon": "🍺",
            "discardBeer": "🍺",
            "stagecoach": "💰",
            "wellsFargo": "💰",
            "drawStore": "💰",
            "gainRewardOnEliminatingOutlaw": "💰",
            "drawHandCardAt1": "‼️",
            "drawInPlayCardAt1": "‼️",
            "discardOtherHand": "❌",
            "discardOtherInPlay": "❌",
            "discardSelfInPlay": "❌",
            "penalizeSheriffOnEliminatingDeputy": "❌",
            "equip": "😎",
            "handicap": "⚠️",
            "dynamite": "💣",
            "jail": "🚧",
            "generalstore": "💰",
            "bang": "🔫",
            "gatling": "🔫",
            "duel": "🔫",
            "indians": "💢",
            "missed": "😝",
            "barrel": "😝",
            "looseHealth": "❤️",
            "endTurn": "✔️",
            "startTurn": "🔥",
            "removeFromPlayOrderOnEliminated": "☠️"
        ]
}

private extension GMove {
    var argsString: String {
        let values: [String] = args.values.flatMap { $0 }
        return values.joined(separator: ", ")
    }
}
