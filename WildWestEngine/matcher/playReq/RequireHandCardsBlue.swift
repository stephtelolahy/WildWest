//
//  RequireHandCardsBlue.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Must choose X blue cards from your hand
 */
class RequireHandCardsBlue: PlayReq {
    
    @ParsedValue
    var amount: Int
    
    override func match(_ ctx: MoveContext, args: inout [[PlayArg: [String]]]) -> Bool {
        var playedCard: String?
        if case let .hand(card) = ctx.card {
            playedCard = card
        }
        let cards = ctx.actor.hand
            .filter { $0.type == .blue }
            .map { $0.identifier }
            .filter { $0 != playedCard }
        return args.appending(values: cards, by: amount, forArg: .requiredHand)
    }
}
