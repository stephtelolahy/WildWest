//
//  RequireTargetReachable.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must target a player at reachable distance
 */
class RequireTargetReachable: PlayReq {
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        let distance = ctx.actor.weapon
        let others = ctx.state.playOrder
            .filter { $0 != ctx.actor.identifier }
            .filter { ctx.state.distance(from: ctx.actor.identifier, to: $0) <= distance }
        return args.appending(values: others, forArg: .target)
    }
}
