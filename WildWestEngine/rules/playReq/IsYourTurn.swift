//
//  IsYourTurn.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be your turn
 */
public class IsYourTurn: PlayReq {
    
    public override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.state.turn == ctx.actor.identifier
    }
}
