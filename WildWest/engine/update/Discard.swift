//
//  Discard.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Discard: GameUpdateProtocol {
    
    let playerIdentifier: String
    let cardIdentifier: String
    
    func apply(to game: GameStateProtocol) {
        guard let player = game.players.first(where: { $0.identifier == playerIdentifier }),
            let card = player.hand.cards.first(where: { $0.identifier == cardIdentifier }) else {
                fatalError("Invalid update")
        }
        
        player.hand.removeCard(card)
        game.deck.addCard(card)
    }
}
