//
//  PassInPlay.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Pass InPlay card to other player
 */
class PassInPlay: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    @Argument(name: "other")
    var other: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let card = ctx.cards(matching: card, player: player).first,
              let other = ctx.players(matching: other).first else {
            return nil
        }
        return [.passInPlay(player: player, card: card, other: other)]
    }
}
