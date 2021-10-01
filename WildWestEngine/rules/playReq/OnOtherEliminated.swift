//
//  OnOtherEliminated.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When other player is eliminated
 */

class OnOtherEliminated: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .eliminate(player, _) = ctx.event,
              player != ctx.actor.identifier else {
            return false
        }
        
        return true
    }
}
