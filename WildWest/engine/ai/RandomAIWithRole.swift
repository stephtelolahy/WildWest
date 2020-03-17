//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAI {
    
    override func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int {
        
        if let bang = move as? Bang {
            return evaluateStrongAttack(from: bang.actorId, to: bang.targetId, in: state)
        }
        
        if let duel = move as? Duel {
            return evaluateStrongAttack(from: duel.actorId, to: duel.targetId, in: state)
        }
        
        if let jail = move as? Jail {
            return evaluateWeakAttack(from: jail.actorId, to: jail.targetId, in: state)
        }
        
        if let panic = move as? Panic {
            if case let .inPlay(cardId) = panic.target.source, cardId.contains("jail") {
                return evaluateHelp(from: panic.actorId, to: panic.target.ownerId, in: state)
            }
            return evaluateWeakAttack(from: panic.actorId, to: panic.target.ownerId, in: state)
        }
        
        if let catBalou = move as? CatBalou {
            if case let .inPlay(cardId) = catBalou.target.source, cardId.contains("jail") {
                return evaluateHelp(from: catBalou.actorId, to: catBalou.target.ownerId, in: state)
            }
            return evaluateWeakAttack(from: catBalou.actorId, to: catBalou.target.ownerId, in: state)
        }
        
        return super.evaluate(move, in: state)
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
        guard let target = players.first(where: { $0.identifier == targetId }),
            let source = players.first(where: { $0.identifier == sourceId }) else {
                return .unknown
        }
        
        return source.role.relationship(to: target.role)
    }
}

private extension Role {
    func relationship(to anotherRole: Role) -> PlayerRelationship {
        switch self {
        case .outlaw:
            return anotherRole == .sheriff ? .enemy : .unknown
            
        case .deputy:
            return anotherRole == .sheriff ? .teammate : .unknown
            
        default:
            return .unknown
        }
    }
}
