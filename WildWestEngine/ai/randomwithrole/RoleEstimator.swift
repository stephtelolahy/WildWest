//
//  RoleEstimator.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//

public protocol RoleEstimatorProtocol {
    func estimatedRole(for player: String, history: [GMove]) -> Role?
}

public class RoleEstimator: RoleEstimatorProtocol {
    
    private let sheriff: String
    private let abilityEvaluator: AbilityEvaluatorProtocol
    
    public init(sheriff: String, abilityEvaluator: AbilityEvaluatorProtocol) {
        self.sheriff = sheriff
        self.abilityEvaluator = abilityEvaluator
    }
    
    public func estimatedRole(for player: String, history: [GMove]) -> Role? {
        let playerScores = buildScores(history: history)
        guard let score = playerScores[player] else {
            return nil
        }
        
        if score > 0 {
            return .outlaw
        } else if score < 0 {
            return .deputy
        } else {
            return nil
        }
        
    }
    
    private func buildScores(history: [GMove]) -> [String: Int] {
        var playerScores: [String: Int] = [:]
        for move in history {
            guard let targets = move.args[.target],
                  targets.contains(sheriff) else {
                continue
            }
            
            let score = abilityEvaluator.evaluate(move)
            playerScores.append(score, forKey: move.actor)
        }
        return playerScores
    }
}

private extension Dictionary where Key == String, Value == Int {
    mutating func append(_ value: Int, forKey key: String) {
        if let previousValue = self[key] {
            self[key] = previousValue + value
        } else {
            self[key] = value
        }
    }
}
