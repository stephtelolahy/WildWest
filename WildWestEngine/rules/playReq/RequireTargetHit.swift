//
//  RequireTargetHit.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 26/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Set target the value of hit.target
 */
class RequireTargetHit: PlayReq {
 
    override func match(_ ctx: PlayContext, args: inout [[PlayArg: [String]]]) -> Bool {
        guard let target = ctx.state.hits.first?.target else {
            return false
        }
        
        return args.appending(values: [target], forArg: .target)
    }
}
