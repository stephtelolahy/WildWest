//
//  OnPlayCard.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When your played a card with regex X
 */
class OnPlayCard: PlayReq {
    
    @ParsedValue
    var regex: String
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard case let .play(player, card) = ctx.event,
              player == ctx.actor.identifier,
              card.matches(regex: regex) else {
            return false
        }
        return true
    }
}
