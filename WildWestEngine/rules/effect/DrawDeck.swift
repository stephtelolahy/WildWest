//
//  DrawDeck.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw X cards from top deck
 */
public class DrawDeck: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "amount", defaultValue: .number(1))
    var amount: NumberArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        let amount = ctx.get(amount)
        return ctx.players(matching: player)
            .flatMap { player in
                Array(0..<amount).map { _ in .drawDeck(player: player) }
            }
    }
}
