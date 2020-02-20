//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAI {
    
    override func evaluate(_ move: ActionProtocol, in state: GameStateProtocol) -> Int {
        
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
        if state.player(targetId, isEnemyOf: actorId) {
            return 3
        } else {
            return -3
        }
    }
    
    private func evaluateWeakAttack(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        if state.player(targetId, isEnemyOf: actorId) {
            return 1
        } else {
            return -2
        }
    }
    
    private func evaluateHelp(from actorId: String, to targetId: String, in state: GameStateProtocol) -> Int {
        if !state.player(targetId, isEnemyOf: actorId) {
            return 3
        } else {
            return -3
        }
    }
}

private extension GameStateProtocol {
    func player(_ targetId: String, isEnemyOf sourceId: String) -> Bool {
        guard let target = players.first(where: { $0.identifier == targetId }),
            let source = players.first(where: { $0.identifier == sourceId }) else {
                return false
        }
        
        let targetRole: Role? = target.role == .sheriff ? .sheriff : nil // sheriff or unknown
        return source.role.isEnnemy(of: targetRole)
    }
}

private extension Role {
    func isEnnemy(of anotherRole: Role?) -> Bool {
        switch self {
        case .deputy:
            return anotherRole != .sheriff
            
        case .outlaw:
            return anotherRole == .sheriff
            
        default:
            return true
        }
    }
}
