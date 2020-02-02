//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardBang: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        
        guard case let .indians(targetIds) = state.challenge else {
            return
        }
        
        let remainingTargetIds = targetIds.filter { $0 != actorId }
        if remainingTargetIds.isEmpty {
            state.setChallenge(nil)
        } else {
            state.setChallenge(.indians(remainingTargetIds))
        }
    }
    
    var description: String {
        "\(actorId) discard \(cardId)"
    }
}

struct DiscardBangRule: RuleProtocol {
    
    let actionName: String = "DiscardBang"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard case let .indians(targetIds) = state.challenge else {
            return  []
        }
        
        guard let actor = state.players.first(where: { $0.identifier == targetIds.first }) else {
            return []
        }
        
        let cards = actor.handCards(named: .bang)
        guard !cards.isEmpty else {
            return []
        }
        
        return cards.map { DiscardBang(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
