//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Beer: ActionProtocol, RuleProtocol {
    
    let playerIdentifier: String
    let cardIdentifier: String
    
    static func match(playerId: String, state: GameStateProtocol) -> [ActionProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        
        let beerCards = player.hand.cards.filter { $0.name == .beer }
        let actions = beerCards.map { Beer(playerIdentifier: playerId, cardIdentifier: $0.identifier) }
        return actions
    }
    
    func execute(state: GameStateProtocol) -> [StateUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerIdentifier }),
            let card = player.hand.cards.first(where: { $0.identifier == cardIdentifier }) else {
                return []
        }
        
        return [Discard(player: player, card: card),
                GainLifePoints(player: player, points: 1)]
    }
}
