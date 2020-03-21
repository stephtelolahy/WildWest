//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveJailMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlay.filter({ $0.name == .dynamite }).isEmpty,
            let card = actor.inPlay.first(where: { $0.name == .jail })  else {
                return nil
        }
        
        return [GameMove(name: .resolve,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         cardName: card.name)]
    }
}

class ResolveJailExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .resolve = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId,
            case .jail = move.cardName,
            let topDeckCard = state.deck.first else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        updates.append(.playerDiscardInPlay(actorId, cardId))
        if !topDeckCard.makeEscapeFromJail {
            updates.append(.setTurn(state.nextTurn))
            updates.append(.setChallenge(.startTurn))
        }
        return updates
    }
}
