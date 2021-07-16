//
//  OnLooseHealth.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you loose health but not eliminated
 */
class OnLooseHealth: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .looseHealth(player, _) = ctx.event,
              player == ctx.actor.identifier,
              ctx.actor.health > 0 else {
            return false
        }
        
        return true
    }
}
