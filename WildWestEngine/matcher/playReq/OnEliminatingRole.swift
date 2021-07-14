//
//  OnEliminatingRole.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you eliminated a player with role X
 */
class OnEliminatingRole: PlayReq {
    
    @ParsedValue
    var role: Role
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .eliminate(target, offender) = ctx.event,
              offender != target,
              offender == ctx.actor.identifier,
              let targetObject = ctx.state.players[target],
              targetObject.role == role else {
            return false
        }
        return true
    }
}
