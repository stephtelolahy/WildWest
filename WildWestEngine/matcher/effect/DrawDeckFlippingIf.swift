//
//  DrawDeckFlippingIf.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Draw top card from deck then reveal
 */
class DrawDeckFlippingIf: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "regex")
    var regex: String
    
    @Argument(name: "then")
    var thenEffects: [Effect]
    
    @Argument(name: "else", defaultValue: [])
    var elseEffects: [Effect]
    
    override func apply(_ ctx: MoveContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first else {
            return nil
        }
        var events: [GEvent] = [.drawDeckFlipping(player: player)]
        
        // <HACK: consider revealed card is deck[1]>
        let cardObject = ctx.state.deck[1]
        // </HACK>
        
        let success = cardObject.matches(regex: regex)
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
