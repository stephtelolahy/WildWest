//
//  OnPhase.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 When phase changed to X
 */
class OnPhase: GPlayReq {
    
    @ParsedValue
    var phase: Int
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        guard case let .setPhase(aPhase) = ctx.event,
              phase == aPhase else {
            return false
        }
        
        return true
    }
}
