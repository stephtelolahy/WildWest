//
//  LooseHealth.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Loose life point
 - Set offender as hit offender
 */
class LooseHealth: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let hit = ctx.state.hits.first(where: { $0.player == player }) else {
            return nil
        }
        
        let playerObject = ctx.state.players[player]!
        if playerObject.health == 1 {
            return [.eliminate(player: player, offender: hit.offender)]
        } else {
            return [.looseHealth(player: player, offender: hit.offender)]
        }
    }
}
