//
//  LooseHealth.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Loose life point
 */
class LooseHealth: GEffect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let offender = ctx.players(matching: .offender).first else {
            return nil
        }
        
        let playerObject = ctx.state.players[player]!
        if playerObject.health == 1 {
            return [.eliminate(player: player, offender: offender)]
        } else {
            return [.looseHealth(player: player, offender: offender)]
        }
    }
}
