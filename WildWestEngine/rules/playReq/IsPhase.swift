//
//  IsPhase.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be on phase X and no playing hit
 */
public class IsPhase: PlayReq {
    
    @ParsedValue
    var phase: Int
    
    public override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.state.phase == phase && ctx.state.hit == nil
    }
}
