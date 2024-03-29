//
//  IsPlayersCountMin.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 The minimum number of players inPlay is X
 */
public class IsPlayersCountMin: PlayReq {
    
    @ParsedValue
    var minPlayersCount: Int
    
    public override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        ctx.state.playOrder.count >= minPlayersCount
    }
}
