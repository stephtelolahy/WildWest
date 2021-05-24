//
//  RequireTargetOffender.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Set target the player that just damaged you
 */
class RequireTargetOffender: PlayReq {
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .looseHealth(player, offender) = ctx.event,
              player == ctx.actor.identifier,
              offender != player,
              ctx.actor.health > 0 else {
            return false
        }
        return args.appending(values: [offender], forArg: .target)
    }
}
