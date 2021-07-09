//
//  Equip.swift
//  WildWestEngine
//
//  Created by Hugues Stéphano TELOLAHY on 22/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

/**
 Put a hand card in self inPlay
 - RULE: cannot have two copies of the same card in play
 - RULE: discard previous weapon if playing new one
 */
public class Equip: Effect {
    
    @Argument(name: "player", defaultValue: .actor)
    var player: PlayerArgument
    
    @Argument(name: "card")
    var card: CardArgument
    
    override func apply(_ ctx: MoveContext) -> [GEvent]? {
        guard let player = ctx.players(matching: player).first,
              let card = ctx.cards(matching: card, player: player).first else {
            return nil
        }
        
        // <RULE> cannot have two copies of the same card in play
        let playerObject = ctx.state.players[player]!
        let cardObject = playerObject.hand.first(where: { $0.identifier == card })!
        guard !playerObject.inPlay.contains(where: { $0.name == cardObject.name }) else {
            return nil
        }
        // </RULE>
        
        var events: [GEvent] = [.equip(player: player, card: card)]
        
        // <RULE> discard previous weapon if playing new one
        if cardObject.isWeapon,
           let previousWeapon = playerObject.inPlay.first(where: { $0.isWeapon }) {
            events.append(.discardInPlay(player: player, card: previousWeapon.identifier))
        }
        // </RULE>
        
        return events
    }
}

private extension CardProtocol {
    var isWeapon: Bool {
        attributes.weapon != nil
    }
}
