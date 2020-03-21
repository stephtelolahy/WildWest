//
//  ResolveDynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveDynamiteMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .dynamite })  else {
                return nil
        }
        
        return [GameMove(name: .resolve, actorId: actor.identifier, cardId: card.identifier, cardName: card.name)]
    }
}

class ResolveDynamiteExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .resolve = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId,
            case .dynamite = move.cardName,
            let topDeckCard = state.deck.first else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        if topDeckCard.makeDynamiteExplode {
            updates.append(.setChallenge(.startTurnDynamiteExploded))
            updates.append(.playerDiscardInPlay(actorId, cardId))
        } else {
            updates.append(.playerPassInPlayOfOther(actorId, state.nextTurn, cardId))
        }
        return updates
    }
}
