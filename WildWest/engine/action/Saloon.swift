//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Saloon: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        for player in state.players where player.health < player.maxHealth {
            state.gainLifePoint(playerId: player.identifier)
        }
    }
}

extension Saloon: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Saloon]? {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .saloon)
        return cards.map { Saloon(actorId: player.identifier, cardId: $0.identifier) }
    }
}
