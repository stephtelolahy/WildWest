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
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        for player in state.players where player.health < player.maxHealth {
            state.gainLifePoint(playerId: player.identifier)
        }
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct SaloonRule: RuleProtocol {
    
    let actionName: String = "Saloon"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .saloon)
        return cards.map { Saloon(actorId: actor.identifier, cardId: $0.identifier) }
    }
}