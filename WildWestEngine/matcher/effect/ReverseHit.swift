//
//  ReverseHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Permute hit player and offender
 */
class ReverseHit: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let hit = ctx.state.hits.first(where: { $0.player == player }) else {
            fatalError("Invalid hit")
        }
        
        return [.removeHit(player: player),
                .addHit(players: [hit.offender], name: hit.name, abilities: hit.abilities, cancelable: hit.cancelable, offender: player)]
        
    }
}
