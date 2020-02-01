//
//  Missed.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Missed: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.setChallenge(nil)
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct MissedRule: RuleProtocol {
    
    let actionName: String = "Missed"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard case let .bang(_, targetId) = state.challenge else {
            return  []
        }
        
        guard let actor = state.players.first(where: { $0.identifier == targetId }) else {
            return []
        }
        
        let cards = actor.handCards(named: .missed)
        guard !cards.isEmpty else {
            return []
        }
        
        return cards.map { Missed(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
