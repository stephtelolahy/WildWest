//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAI {
    
    private let classifier: MoveClassifierProtocol = MoveClassifier()
    private let statsBuilder = StatsBuilder()
    private var scores: [String: Int] = [:]
    
    override func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int {
        scores = statsBuilder.buildScore(state: state)
        
        let classification = classifier.classify(move)
        switch classification {
        case let .strongAttack(actorId, targetId):
            return evaluateStrongAttack(from: actorId, to: targetId, in: state)
            
        case let .weakAttack(actorId, targetId):
            return evaluateWeakAttack(from: actorId, to: targetId, in: state)
            
        case let .help(actorId, targetId):
            return evaluateHelp(from: actorId, to: targetId, in: state)
            
        default:
            return super.evaluate(move, in: state)
        }
    }
    
    private func evaluateStrongAttack(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId, scores: scores) {
        case .enemy:
            return Score.strongAttackEnemy
        case .teammate:
            return Score.strongAttackTeammate
        case .unknown:
            return Score.strongAttackUnknown
        }
    }
    
    private func evaluateWeakAttack(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId, scores: scores) {
        case .enemy:
            return Score.weakAttackEnemy
        case .teammate:
            return Score.weakAttackTeammate
        case .unknown:
            return Score.weakAttackUnknown
        }
    }
    
    private func evaluateHelp(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId, scores: scores) {
        case .enemy:
            return Score.helpEnemy
        case .teammate:
            return Score.helpTeammate
        case .unknown:
            return Score.helpUnknown
        }
    }
}

private extension GameStateProtocol {
    
    func relationship(of sourceId: String, to targetId: String, scores: [String: Int]) -> Relationship {
        guard let source = player(sourceId),
            let sourceRole = source.role,
            let target = player(targetId) else {
                fatalError("Illegal state")
        }
        
        let targetRole = target.role ?? Role.estimatedRole(for: targetId, scores: scores)
        return sourceRole.relationShip(to: targetRole, playersCount: players.count)
    }
}
