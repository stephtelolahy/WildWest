//
//  DiscardMissed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardMissedMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case let .shoot(targetIds, _, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.handCards(named: .missed) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class DiscardMissedExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            case .missed = move.cardName,
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(state.challenge?.removing(actorId))]
    }
}
