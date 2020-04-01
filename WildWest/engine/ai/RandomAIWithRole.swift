//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAI {
    
    private let classifier: MoveClassifierProtocol = MoveClassifier()
    
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
    
    private func evaluateStrongAttack(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId) {
        case .enemy:
            return Score.strongAttackEnemy
        case .teammate:
            return Score.strongAttackTeammate
        case .unknown:
            return Score.strongAttackUnknown
        }
    }
    
    private func evaluateWeakAttack(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId) {
        case .enemy:
            return Score.weakAttackEnemy
        case .teammate:
            return Score.weakAttackTeammate
        case .unknown:
            return Score.weakAttackUnknown
        }
    }
    
    private func evaluateHelp(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        switch state.relationship(of: actorId, to: targetId) {
        case .enemy:
            return Score.helpEnemy
        case .teammate:
            return Score.helpTeammate
        case .unknown:
            return Score.helpUnknown
        }
    }
}

private enum PlayerRelationship {
    case enemy
    case teammate
    case unknown
}

private extension GameStateProtocol {
    func relationship(of sourceId: String, to targetId: String) -> PlayerRelationship {
        guard let target = player(targetId),
            let source = player(sourceId) else {
                return .unknown
        }
        
        switch source.role {
        case .outlaw:
            return target.role == .sheriff ? .enemy : .unknown
            
        case .deputy:
            return target.role == .sheriff ? .teammate : .unknown
            
        case .renegade:
            if target.role == .sheriff {
                return players.count > 2 ? .teammate : .enemy
            } else {
                return .unknown
            }
            
        default:
            return .unknown
        }
    }
}
