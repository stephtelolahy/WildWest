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
        "\(actorId) plays \(cardId)"
    }
}

struct SaloonRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil else {
            return nil
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .saloon)
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [Saloon(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
