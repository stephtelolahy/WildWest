//
//  IsHitCancelable.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be target of hit that is cancelable
 */
class IsHitCancelable: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard let hit = ctx.state.hit,
              hit.players.first == ctx.actor.identifier,
              hit.cancelable > 0 else {
            return false
        }
        return true
    }
}
