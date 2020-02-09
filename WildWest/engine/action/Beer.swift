//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Beer: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct BeerRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        let cards = actor.handCards(named: .beer)
        guard !cards.isEmpty,
            state.players.count > 2,
            actor.health < actor.maxHealth else {
                return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [Beer(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
