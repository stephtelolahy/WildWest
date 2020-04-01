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
            let actor = state.players.first(where: { $0.identifier == move.actorId }),
            actor.health == 0 else {
                return nil
        }
        
        return GameMove(name: .eliminate, actorId: move.actorId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .eliminate = move.name,
            let actor = state.players.first(where: { $0.identifier == move.actorId }) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        actor.hand.forEach { updates.append(.playerDiscardHand(move.actorId, $0.identifier)) }
        actor.inPlay.forEach { updates.append(.playerDiscardInPlay(move.actorId, $0.identifier)) }
        updates.append(.eliminatePlayer(move.actorId))
        if move.actorId == state.turn {
            updates.append(.setTurn(state.nextTurn))
            updates.append(.setChallenge(Challenge(name: .startTurn)))
        }
        
        return updates
    }
}

extension MoveName {
    static let eliminate = MoveName("eliminate")
}
