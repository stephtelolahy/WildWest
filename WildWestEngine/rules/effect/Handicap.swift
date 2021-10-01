//
//  Handicap.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Put a hand card in other's inPlay
 - RULE: cannot have two copies of the same card in play
 */
public class Handicap: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    @Argument(name: "other")
    var other: PlayerArgument
    
    override func apply(_ ctx: PlayContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let card = ctx.cards(matching: card, player: player).first,
              let other = ctx.players(matching: other).first else {
            return nil
        }
        
        // <RULE> cannot have two copies of the same card in play
        let cardObject = ctx.actor.hand.first(where: { $0.identifier == card })!
        let otherObject = ctx.state.players[other]!
        if otherObject.inPlay.contains(where: { $0.name == cardObject.name }) {
            return []
        }
        // </RULE>
        
        return [.handicap(player: player, card: card, other: other)]
    }
}
