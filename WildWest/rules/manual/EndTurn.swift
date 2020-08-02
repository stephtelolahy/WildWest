//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class EndTurnMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn) else {
                return nil
        }
        
        let discardCount = actor.hand.count - actor.health
        
        guard discardCount > 0 else {
            return [GameMove(name: .endTurn, actorId: actor.identifier)]
        }
        
        let cardCombinations = actor.hand.map { $0.identifier }.combine(by: discardCount)
        return cardCombinations.map {
            GameMove(name: .endTurn, actorId: actor.identifier, discardIds: $0)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .endTurn = move.name,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        
        updates.append(.setTurn(state.nextPlayer(after: move.actorId)))
        updates.append(.setChallenge(Challenge(name: .startTurn)))
        
        if let discardIds = move.discardIds {
            discardIds.forEach { updates.append(.playerDiscardHand(actor.identifier, $0)) }
        }
        
        return updates
    }
}

extension MoveName {
    static let endTurn = MoveName("endTurn")
}
