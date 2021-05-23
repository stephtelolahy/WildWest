//
//  IsPhase.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must be on phase X and hits is empty
 */
public class IsPhase: GPlayReq {
    
    @ParsedValue
    var phase: Int
    
    public override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        ctx.state.phase == phase && ctx.state.hits.isEmpty
    }
}
