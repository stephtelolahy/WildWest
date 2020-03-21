//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class BeerMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .beer),
            state.players.count > 2,
            actor.health < actor.maxHealth else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .play,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class BeerExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            case .beer = move.cardName,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .playerGainHealth(actorId, 1)]
    }
}
