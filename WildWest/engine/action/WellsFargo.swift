//
//  WellsFargo.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct WellsFargo: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct WellsFargoRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil else {
            return nil
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .wellsFargo)
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [WellsFargo(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
