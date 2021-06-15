//
//  RoleEstimator.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//

public protocol RoleEstimatorProtocol {
    func score(for player: String) -> Int
    func estimatedRole(for player: String) -> Role?
    func update(on move: GMove)
}

public class RoleEstimator: RoleEstimatorProtocol {
    
    private let sheriff: String
    private var playerScores: [String: Int]
    private let abilityEvaluator: AbilityEvaluatorProtocol
    
    public init(sheriff: String, 
                playerScores: [String: Int] = [:],
                abilityEvaluator: AbilityEvaluatorProtocol) {
        self.sheriff = sheriff
        self.playerScores = playerScores
        self.abilityEvaluator = abilityEvaluator
    }
    
    public func score(for player: String) -> Int {
        playerScores[player] ?? 0
    }
    
    public func estimatedRole(for player: String) -> Role? {
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
    
    public func update(on move: GMove) {
        guard let targets = move.args[.target],
              targets.contains(sheriff) else {
            return
        }
        
        let score = abilityEvaluator.evaluate(move)
        playerScores.append(score, forKey: move.actor)
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
