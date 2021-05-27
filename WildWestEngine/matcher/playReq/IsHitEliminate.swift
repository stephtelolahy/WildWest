//
//  IsHitEliminate.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be target of hit that will eliminates you
 */
public class IsHitEliminate: PlayReq {
    
    public override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard let hit = ctx.state.hits.first,
              hit.player == ctx.actor.identifier,
              hit.abilities.contains("looseHealth"),
              ctx.actor.health == 1 else {
            return false
        }
        return true
    }
}
