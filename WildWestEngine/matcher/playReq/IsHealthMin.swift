//
//  IsHealthMin.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Your health must be at least X
 */
public class IsHealthMin: PlayReq {
    
    @ParsedValue
    var minHealth: Int
    
    public override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.actor.health >= minHealth
    }
}
