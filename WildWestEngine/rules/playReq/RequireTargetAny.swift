//
//  RequireTargetAny.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must target any other player
 */
public class RequireTargetAny: GPlayReq {
    
    @ParsedValue
    var minPlayersCount: Int
    
    public override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        let others = ctx.state.playOrder
            .filter { $0 != ctx.actor.identifier }
        return args.appending(values: others, forArg: .target)
    }
}
