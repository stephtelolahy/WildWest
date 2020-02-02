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
        "\(actorId) play \(cardId)"
    }
}

struct WellsFargoRule: RuleProtocol {
    
    let actionName: String = "WellsFargo"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .wellsFargo)
        return cards.map { WellsFargo(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
