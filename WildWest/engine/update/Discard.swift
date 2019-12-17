//
//  Discard.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Discard: StateUpdateProtocol {
    
    let player: PlayerProtocol
    let card: CardProtocol
    
    func apply(to state: GameStateProtocol) {
        player.hand.remove(card)
        state.deck.add(card)
        state.addMessage("\(player.identifier) discard \(card.identifier)")
    }
}
