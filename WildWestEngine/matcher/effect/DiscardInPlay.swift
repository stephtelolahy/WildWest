//
//  DiscardInPlay.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Discard inPlay card to discard pile
 */
public class DiscardInPlay: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        
        let cards = ctx.cards(matching: card, player: player)
        return cards.map { .discardInPlay(player: player, card: $0) }
    }
}
