//
//  DrawDiscard.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw top card from discard pile
 */
class DrawDiscard: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              !ctx.state.discard.isEmpty else {
            return nil
        }
        
        return [.drawDiscard(player: player)]
    }
}
