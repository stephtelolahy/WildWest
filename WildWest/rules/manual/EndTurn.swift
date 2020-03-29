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
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        return [GameMove(name: .endTurn, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .endTurn = move.name,
            let actor = state.players.first(where: { $0.identifier == move.actorId }) else {
            return nil
        }
        
        guard actor.hand.count <= actor.health else {
            return [.setChallenge(Challenge(name: .discardExcessCards, actorId: actor.identifier))]
        }
        
        return [.setTurn(state.nextTurn),
                .setChallenge(Challenge(name: .startTurn))]
    }
}

extension MoveName {
    static let endTurn = MoveName("endTurn")
}
