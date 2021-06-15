//
//  MoveEvaluator.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//

public protocol MoveEvaluatorProtocol {
    func evaluate(_ move: GMove, in state: StateProtocol) -> Int
}

public class MoveEvaluator: MoveEvaluatorProtocol {
    
    private let abilityEvaluator: AbilityEvaluatorProtocol
    private let roleEstimator: RoleEstimatorProtocol
    private let roleStrategy: RoleStrategyProtocol
    
    public init(abilityEvaluator: AbilityEvaluatorProtocol, 
                roleEstimator: RoleEstimatorProtocol,
                roleStrategy: RoleStrategyProtocol) {
        self.abilityEvaluator = abilityEvaluator
        self.roleEstimator = roleEstimator
        self.roleStrategy = roleStrategy
    }
    
    public func evaluate(_ move: GMove, in state: StateProtocol) -> Int {
        let score = abilityEvaluator.evaluate(move)
        
        guard let target = move.args[.target]?.first else {
            return score
        }
        
        guard let actorObject = state.players[move.actor],
              let actorRole = actorObject.role,
              let targetObject = state.players[target], 
              let targetRole = targetObject.role ?? roleEstimator.estimatedRole(for: target) else {
            return 0
        }
        
        let strategy = roleStrategy.relationship(of: actorRole, to: targetRole, in: state)
        return score * strategy
    }
}
