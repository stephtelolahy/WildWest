//
//  IsTimesPerTurnMax.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 May be played at most X-1 times during current turn
 */
class IsTimesPerTurnMax: PlayReq {
    
    @ParsedValue
    var maxTimes: NumberArgument
    
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        let times = ctx.get(maxTimes)
        if times == 0 {
            return true
        }
        
        return ctx.state.played.filter { $0 == ctx.ability }.count < times
    }
}
