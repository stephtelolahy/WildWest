//
//  OnHandEmpty.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When your hand is empty
 */
class OnHandEmpty: PlayReq {
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        switch ctx.event {
        case let .play(player, _):
            return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
            
        case let .discardHand(player, _):
            return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
            
        case let .equip(player, _):
            return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
            
        case let .handicap(player, _, _):
            return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
            
        case let .drawHand(_, target, _):
            return target == ctx.actor.identifier && ctx.actor.hand.isEmpty
            
        default:
            return false
        }
    }
}
