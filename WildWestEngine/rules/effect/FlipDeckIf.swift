//
//  FlipDeckIf.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 23/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Flip over the top card of the deck, then apply effects according to suits and values
 */
class FlipDeckIf: Effect {
    
    @Argument(name: "regex")
    var regex: String
    
    @Argument(name: "then")
    var thenEffects: [Effect]
    
    @Argument(name: "else", defaultValue: [])
    var elseEffects: [Effect]
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        let amount = AttributeRules.flippedCards(for: ctx.actor)
        var events: [GEvent] = Array(0..<amount).map { _ in .flipDeck }
        let cards = ctx.state.deck.prefix(amount)
        let success = cards.contains(where: { $0.matches(regex: regex) })
        if success {
            let outcomeEvents: [GEvent] = thenEffects.compactMap { $0.apply(ctx) }.flatMap { $0 }
            events.append(contentsOf: outcomeEvents)
        } else {
            let outcomeEvents: [GEvent] = elseEffects.compactMap { $0.apply(ctx) }.flatMap { $0 }
            events.append(contentsOf: outcomeEvents)
        }
        return events
    }
}
