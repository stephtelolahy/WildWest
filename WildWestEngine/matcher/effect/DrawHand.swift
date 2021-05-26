//
//  DrawHand.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw a card from other player's hand
 */
public class DrawHand: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "other")
    var other: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let other = ctx.players(matching: other).first else {
            return nil
        }
        let cards = ctx.cards(matching: card, player: other)
        return cards.map { .drawHand(player: player, other: other, card: $0) }
    }
}
