//
//  OnEliminated.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you loose your last health
 */
class OnEliminated: PlayReq {
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .eliminate(player, _) = ctx.event,
              player == ctx.actor.identifier else {
            return false
        }
        
        return true
    }
}
