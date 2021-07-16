//
//  OnPlayCardOutOfTurn.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 02/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you play a hand card out of your turn
 */
class OnPlayCardOutOfTurn: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .play(player, _) = ctx.event,
              player == ctx.actor.identifier,
              ctx.state.turn != player else {
            return false
        }
        
        return true
    }
}
