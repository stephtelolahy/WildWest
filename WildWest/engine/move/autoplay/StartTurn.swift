//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartTurnMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.health > 0,
            !actor.inPlay.contains(where: { $0.name == .jail || $0.name == .dynamite }) else {
                return nil
        }
        
        return [GameMove(name: .startTurn, actorId: actor.identifier)]
    }
}

class StartTurnExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .startTurn = move.name,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerPullFromDeck(actorId, 2),
                .setChallenge(nil)]
    }
}
