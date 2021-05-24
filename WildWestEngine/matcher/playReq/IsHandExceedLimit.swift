//
//  IsHandExceedLimit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When having more cards than hand limit
 */
class IsHandExceedLimit: PlayReq {
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.actor.hand.count > ctx.actor.handLimit
    }
}
