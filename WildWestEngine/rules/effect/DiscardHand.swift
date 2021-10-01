//
//  DiscardHand.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Discard hand card to discard pile
 */
public class DiscardHand: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        
        let cards = ctx.cards(matching: card, player: player)
        return cards.map { .discardHand(player: player, card: $0) }
    }
}
