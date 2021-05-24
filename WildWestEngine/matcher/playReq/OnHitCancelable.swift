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
class OnHitCancelable: GPlayReq {
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        guard case let .addHit(players, _, _, cancelable, _) = ctx.event,
              players.contains(ctx.actor.identifier),
              cancelable > 0 else {
            return false
        }
        return true
    }
}
