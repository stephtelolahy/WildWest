//
//  IsHitEffect.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 19/08/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be target of hit that requires ability X
 */
class IsHitEffect: PlayReq {
    
    @ParsedValue
    var ability: String
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard let hit = ctx.state.hits.first,
              hit.player == ctx.actor.identifier,
              hit.abilities.contains(ability) else {
            return false
        }
        return true
    }
}
