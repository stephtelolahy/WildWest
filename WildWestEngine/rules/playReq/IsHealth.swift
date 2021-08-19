//
//  IsHealth.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 19/08/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Your health must be equal to X
 */
public class IsHealth: PlayReq {
    
    @ParsedValue
    var health: Int
    
    public override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.actor.health == health
    }
}
