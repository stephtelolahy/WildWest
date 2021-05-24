//
//  RequireInPlayCard.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must choose any card in play of targeted
 */
public class RequireInPlayCard: GPlayReq {
    
    @ParsedValue
    var minPlayersCount: Int
    
    public override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        args.appendingRequiredInPlay(state: ctx.state)
    }
}