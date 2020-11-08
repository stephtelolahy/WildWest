//
//  MoveDescriptor.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import CardGameEngine

protocol MoveDescriptorProtocol {
    func description(for move: GMove) -> String
}

class MoveDescriptor: MoveDescriptorProtocol {
    
    func description(for move: GMove) -> String {
        String(describing: move)
//        guard let emoji = emojis[move.name] else {
//            fatalError("Illegal state")
//        }
//        
//        return "\(emoji) \(move.description)"
    }
    /*
    private let emojis: [MoveName: String] =
        [
            .beer: "🍺",
            .saloon: "🍻",
            .stagecoach: "💰",
            .wellsFargo: "💰",
            .panic: "‼️",
            .catBalou: "❌",
            .equip: "😎",
            .dynamite: "💣",
            .jail: "🚧",
            .generalStore: "💰",
            .bang: "🔫",
            .gatling: "🔫",
            .indians: "💢",
            .duel: "🔫",
            .discardMissed: "😝",
            .discardBang: "🔫",
            .discardBeer: "🍺",
            .pass: "❤️",
            .choose: "💰",
            .endTurn: "✔️",
            .startTurn: "🔥",
            .startTurnDrawAnotherCardIfRedSuit: "🔥",
            .startTurnDraw3CardsAndKeep2: "🔥",
            .startTurnDrawFirstCardFromOtherPlayer: "🔥",
            .startTurnDrawFirstCardFromDiscard: "🔥",
            .passDynamite: "💣",
            .dynamiteExploded: "💥",
            .stayInJail: "😞",
            .escapeFromJail: "😅",
            .useBarrel: "😝",
            .failBarrel: "😞",
            .eliminate: "☠️",
            .gainRewardOnEliminatingOutlaw: "🎁",
            .penalizeSheriffOnEliminatingDeputy: "⚠️",
            .drawsCardOnLoseHealth: "💰",
            .drawsCardFromPlayerDamagedHim: "‼️",
            .drawsCardWhenHandIsEmpty: "💰",
            .discard2CardsFor1Life: "🍺"
        ]
 */
}
