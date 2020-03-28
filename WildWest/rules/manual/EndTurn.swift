//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class EndTurnMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        let haveExcessCards = actor.hand.count > actor.health
        guard haveExcessCards else {
            return [GameMove(name: .endTurn, actorId: actor.identifier)]
        }
        
        let cardsToDiscardCount = actor.hand.count - actor.health
        let handCardIds = actor.hand.map { $0.identifier }
        let cardsCombinations = handCardIds.combine(by: cardsToDiscardCount)
        return cardsCombinations.map { GameMove(name: .endTurn, actorId: actor.identifier, discardIds: $0) }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .endTurn = move.name,
            let actorId = move.actorId else {
            return nil
        }
        
        var updates: [GameUpdate] = []
        if let cardIds = move.discardIds {
            cardIds.forEach { updates.append(.playerDiscardHand(actorId, $0)) }
        }
        updates.append(.setTurn(state.nextTurn))
        updates.append(.setChallenge(.startTurn))
        return updates
    }
}

extension MoveName {
    static let endTurn = MoveName("endTurn")
}
