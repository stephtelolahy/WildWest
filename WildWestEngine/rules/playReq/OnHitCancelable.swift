//
//  OnHitCancelable.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you are target of hit that is cancelable with a 'missed' card
 */
class OnHitCancelable: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .addHit(hits) = ctx.event,
              let hit = hits.first(where: { $0.player == ctx.actor.identifier }),
              hit.cancelable > 0 else {
            return false
        }
        return true
    }
}
