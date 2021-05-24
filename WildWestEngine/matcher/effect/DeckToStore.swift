//
//  DeckToStore.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw X cards from deck to store
 */
class DeckToStore: GEffect {
    
    @Argument(name: "amount")
    var amount: NumberArgument
    
    override func apply(_ ctx: EffectContext) -> [GEvent]? {
        let amount = ctx.number(matching: amount)
        return  Array(0..<amount).map { _ in .deckToStore }
    }
}
