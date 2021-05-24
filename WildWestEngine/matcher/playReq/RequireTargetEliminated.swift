//
//  RequireTargetEliminated.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Set target the player that just is eliminated
 */
class RequireTargetEliminated: GPlayReq {
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        guard case let .eliminate(target, _) = ctx.event,
              target != ctx.actor.identifier else {
            return false
        }
        return args.appending(values: [target], forArg: .target)
    }
}
