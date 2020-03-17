//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class BeerMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [String: [GameMove]]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .beer),
            state.players.count > 2,
            actor.health < actor.maxHealth else {
                return nil
        }
        
        let moves: [GameMove] = cards.map { .beer(actorId: actor.identifier, cardId: $0.identifier) }
        return [actor.identifier: moves]
    }
}

class BeerExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case let .beer(actorId, cardId) = move else {
            return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .playerGainHealth(actorId, 1)]
    }
}
