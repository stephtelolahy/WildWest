//
//  RequireStoreCards.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must choose choose X cards from store
 */
class RequireStoreCards: GPlayReq {
    
    @ParsedValue
    var amount: Int
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg : [String]]]) -> Bool {
        let cards = ctx.state.store
            .map { $0.identifier }
        return args.appending(values: cards, by: amount, forArg: .requiredStore)
    }
}
