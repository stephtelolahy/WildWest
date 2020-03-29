//
//  Eliminate.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class EliminateMatcher: MoveMatcherProtocol {
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .pass = move.name,
            let actorId = move.actorId,
            let actor = state.players.first(where: { $0.identifier == actorId }),
            actor.health == 0 else {
                return nil
        }
        
        return GameMove(name: .eliminate, actorId: actorId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .eliminate = move.name,
            let actorId = move.actorId,
            let actor = state.players.first(where: { $0.identifier == actorId }) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        actor.hand.forEach { updates.append(.playerDiscardHand(actorId, $0.identifier)) }
        actor.inPlay.forEach { updates.append(.playerDiscardInPlay(actorId, $0.identifier)) }
        updates.append(.eliminatePlayer(actorId))
        if actorId == state.turn {
            updates.append(.setTurn(state.nextTurn))
            updates.append(.setChallenge(Challenge(name: .startTurn)))
        }
        
        if let outcome = state.claculateOutcome() {
            updates.append(.setOutcome(outcome))
        }
        
        return updates
    }
}

extension MoveName {
    static let eliminate = MoveName("eliminate")
}
