//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveBarrelMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        let maxBarrelsResolved = 1
        guard case let .shoot(targetIds, _, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.inPlayCards(named: .barrel),
            state.barrelsResolved < maxBarrelsResolved else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .resolve,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class ResolveBarrelExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .resolve = move.name,
            case .barrel = move.cardName,
            let actorId = move.actorId,
            let topDeckCard = state.deck.first else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        if topDeckCard.makeBarrelSuccessful {
            updates.append(.setChallenge(state.challenge?.removing(actorId)))
        }
        return updates
    }
}
