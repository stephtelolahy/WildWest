//
//  RequireDeckCards.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must choose X cards from top deck among (X + 1)
 */
class RequireDeckCards: PlayReq {
    
    @ParsedValue
    var amount: Int
    
    override func match(_ ctx: PlayReqContext, args: inout [[PlayArg: [String]]]) -> Bool {
        let cards = ctx.state.deck.prefix(amount + 1).map { $0.identifier }
        return args.appending(values: cards, by: amount, forArg: .requiredDeck)
    }
}
