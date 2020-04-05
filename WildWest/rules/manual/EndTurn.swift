//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class EndTurnMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn) else {
                return nil
        }
        
        return [GameMove(name: .endTurn, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .endTurn = move.name,
            let actor = state.player(move.actorId) else {
            return nil
        }
        
        guard actor.hand.count <= actor.health else {
            return [.setChallenge(Challenge(name: .discardExcessCards))]
        }
        
        return [.setTurn(state.nextPlayer(after: move.actorId)),
                .setChallenge(Challenge(name: .startTurn))]
    }
}

extension MoveName {
    static let endTurn = MoveName("endTurn")
}
