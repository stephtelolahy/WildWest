//
//  RequireTargetAt.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must target any other player at distance of X
 */
public class RequireTargetAt: PlayReq {
    
    @ParsedValue
    var distance: NumberArgument
    
    public override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        let distance = ctx.get(distance)
        let others = ctx.state.playOrder
            .filter { $0 != ctx.actor.identifier }
            .filter { DistanceRules.distance(from: ctx.actor.identifier, to: $0, in: ctx.state) <= distance }
        return args.appending(values: others, forArg: .target)
    }
}
