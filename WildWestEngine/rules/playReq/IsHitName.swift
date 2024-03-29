//
//  IsHitName.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be first to resolve hit named X
 */
class IsHitName: PlayReq {
    
    @ParsedValue
    var hitName: String
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard let hit = ctx.state.hit,
              hit.players.first == ctx.actor.identifier,
              hit.name == hitName else {
            return false
        }
        return true
    }
}
