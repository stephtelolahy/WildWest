//
//  DrawDeckChoosing.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw specific cards from deck
 */
class DrawDeckChoosing: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: MoveContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        
        let cards = ctx.cards(matching: card, player: player)
        return cards.map { .drawDeckChoosing(player: player, card: $0) }
    }
}
