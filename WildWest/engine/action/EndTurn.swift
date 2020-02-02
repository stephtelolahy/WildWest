//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct EndTurn: ActionProtocol, Equatable {
    let actorId: String
    let cardsToDiscardIds: [String]
    
    func execute(in state: GameStateProtocol) {
        cardsToDiscardIds.forEach { state.discardHand(playerId: actorId, cardId: $0) }
        let nextIndex = (state.turn + 1) % state.players.count
        state.setTurn(nextIndex)
        state.setChallenge(.startTurn)
    }
    
    var description: String {
        var text = "\(actorId) end turn"
        if !cardsToDiscardIds.isEmpty {
            text += " dropping \( cardsToDiscardIds.joined(separator: ","))"
        }
        return text
    }
}

struct EndTurnRule: RuleProtocol {
    
    let actionName: String = "EndTurn"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        
        if actor.hand.count <= actor.health {
            return [EndTurn(actorId: actor.identifier, cardsToDiscardIds: [])]
        }
        
        let cardsToDiscardCount = actor.hand.count - actor.health
        let handCardIds = actor.hand.map { $0.identifier }
        let cardsCombinations = handCardIds.combine(by: cardsToDiscardCount)
        return cardsCombinations.map { EndTurn(actorId: actor.identifier, cardsToDiscardIds: $0) }
    }
}
