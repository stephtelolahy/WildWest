//
//  RequireTargetAny.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must target any player
 */
public class RequireTargetAny: PlayReq {
    
    public override func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        let players = ctx.state.playOrder
        return args.appending(values: players, forArg: .target)
    }
}
