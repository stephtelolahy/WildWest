//
//  OnPlayHandOutOfTurn.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 02/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When you play a card out of your turn
 */
class OnPlayHandOutOfTurn: PlayReq {
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .play(player, _) = ctx.event,
              player == ctx.actor.identifier,
              ctx.state.turn != player else {
            return false
        }
        
        return true
    }
}
