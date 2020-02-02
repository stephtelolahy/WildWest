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
        
        guard case let .shoot(targetIds) = state.challenge else {
            return
        }
        
        let remainingTargetIds = targetIds.filter { $0 != actorId }
        if remainingTargetIds.isEmpty {
            state.setChallenge(nil)
        } else {
            state.setChallenge(.shoot(remainingTargetIds))
        }
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct MissedRule: RuleProtocol {
    
    let actionName: String = "Missed"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard case let .shoot(targetIds) = state.challenge else {
            return  []
        }
        
        guard let actor = state.players.first(where: { $0.identifier == targetIds.first }) else {
            return []
        }
        
        let cards = actor.handCards(named: .missed)
        guard !cards.isEmpty else {
            return []
        }
        
        return cards.map { Missed(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
