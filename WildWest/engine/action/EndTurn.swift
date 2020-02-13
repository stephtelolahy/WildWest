//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct EndTurn: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    let cardsToDiscardIds: [String]
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let turnIndex = state.players.firstIndex(where: { $0.identifier == state.turn }) else {
            return []
        }
        
        var updates: [GameUpdate] = cardsToDiscardIds.map { GameUpdate.playerDiscardHand(actorId, $0) }
        let nextIndex = (turnIndex + 1) % state.players.count
        let nextPlayer = state.players[nextIndex]
        updates.append(.setTurn(nextPlayer.identifier))
        updates.append(.setChallenge(.startTurn))
        return updates
    }
    
    var description: String {
        var text = "\(actorId) end turn"
        if !cardsToDiscardIds.isEmpty {
            text += " discarding \( cardsToDiscardIds.joined(separator: ", "))"
        }
        return text
    }
}

struct EndTurnRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        let haveExcessCards = actor.hand.count > actor.health
        guard haveExcessCards else {
            return [EndTurn(actorId: actor.identifier, cardsToDiscardIds: [])]
        }
        
        let cardsToDiscardCount = actor.hand.count - actor.health
        let handCardIds = actor.hand.map { $0.identifier }
        let cardsCombinations = handCardIds.combine(by: cardsToDiscardCount)
        return cardsCombinations.map { EndTurn(actorId: actor.identifier, cardsToDiscardIds: $0) }
    }
}
