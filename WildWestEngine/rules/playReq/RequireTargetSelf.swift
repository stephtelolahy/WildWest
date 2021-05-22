//
//  RequireTargetSelf.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be yourself as the target
 */
public class RequireTargetSelf: GPlayReq {
    
    @ParsedIntValue()
    var minPlayersCount: Int
    
    public override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        args.appending(values: [ctx.actor.identifier], forArg: .target)
    }
}

