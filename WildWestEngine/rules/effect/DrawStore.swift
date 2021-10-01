//
//  DrawStore.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw a card from store
 */
class DrawStore: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        
        let cards = ctx.cards(matching: card, player: player)
        return cards.map { .drawStore(player: player, card: $0) }
    }
}
