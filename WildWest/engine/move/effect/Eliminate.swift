//
//  Eliminate.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class EliminateMatcher: EffectMatcherProtocol {
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .pass = move.name,
            let actorId = move.actorId,
            let actor = state.players.first(where: { $0.identifier == actorId }),
            actor.health == 0 else {
                return nil
        }
        
        return GameMove(name: .eliminate, actorId: actorId)
    }
}

class EliminateExecutor: MoveExecutorProtocol {
    
    private let calculator: OutcomeCalculatorProtocol
    
    init(calculator: OutcomeCalculatorProtocol) {
        self.calculator = calculator
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
            updates.append(.setChallenge(.startTurn))
        }
        
        let remainingRoles = state.players.filter { $0.identifier != actorId }.compactMap { $0.role }
        if let outcome = calculator.outcome(for: remainingRoles) {
            updates.append(.setOutcome(outcome))
        }
        
        return updates
    }
}
