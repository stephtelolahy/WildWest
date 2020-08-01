//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAI {
    
    private let classifier: MoveClassifierProtocol
    private let roleEstimator: RoleEstimatorProtoccol
    
    init(classifier: MoveClassifierProtocol, roleEstimator: RoleEstimatorProtoccol) {
        self.classifier = classifier
        self.roleEstimator = roleEstimator
    }
    
    override func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int {
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
    
}

private extension RandomAIWithRole {
    
    func evaluateStrongAttack(from actorId: String,
                              to targetId: String,
                              in state: GameStateProtocol) -> Int {
        switch relationship(of: actorId, to: targetId, in: state) {
        case .enemy:
            return Score.strongAttackEnemy
        case .teammate:
            return Score.strongAttackTeammate
        case .unknown:
            return Score.strongAttackUnknown
        }
    }
    
    func evaluateWeakAttack(from actorId: String,
                            to targetId: String,
                            in state: GameStateProtocol) -> Int {
        switch relationship(of: actorId, to: targetId, in: state) {
        case .enemy:
            return Score.weakAttackEnemy
        case .teammate:
            return Score.weakAttackTeammate
        case .unknown:
            return Score.weakAttackUnknown
        }
    }
    
    func evaluateHelp(from actorId: String,
                      to targetId: String,
                      in state: GameStateProtocol) -> Int {
        switch relationship(of: actorId, to: targetId, in: state) {
        case .enemy:
            return Score.helpEnemy
        case .teammate:
            return Score.helpTeammate
        case .unknown:
            return Score.helpUnknown
        }
    }
    
    func relationship(of sourceId: String, to targetId: String, in state: GameStateProtocol) -> Relationship {
        guard let source = state.player(sourceId),
            let sourceRole = source.role,
            let target = state.player(targetId) else {
                fatalError("Illegal state")
        }
        
        let targetRole = target.role ?? roleEstimator.estimateRole(for: targetId)
        return sourceRole.relationShip(to: targetRole, playersCount: state.players.count)
    }
}
