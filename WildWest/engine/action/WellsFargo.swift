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
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .playerPullCardFromDeck(actorId),
            .playerPullCardFromDeck(actorId),
            .playerPullCardFromDeck(actorId)
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct WellsFargoRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .wellsFargo) else {
                return nil
        }
        
        return cards.map { WellsFargo(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
