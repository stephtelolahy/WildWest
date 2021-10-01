//
//  CancelHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Cancel hit
 */
class CancelHit: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        guard let hit = ctx.state.hit,
              hit.cancelable > 0 else {
            return []
        }
        let remainingCancelable = hit.cancelable - 1
        if remainingCancelable > 0 {
            return [.decrementHitCancelable]
        } else {
            return [.removeHit(player: player)]
        }
    }
}
