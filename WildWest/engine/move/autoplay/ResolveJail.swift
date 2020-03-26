//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StayInJailMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlay.filter({ $0.name == .dynamite }).isEmpty,
            let card = actor.inPlay.first(where: { $0.name == .jail }),
            let topDeckCard = state.deck.first,
            !topDeckCard.makeEscapeFromJail else {
                return nil
        }
        
        return [GameMove(name: .stayInJail, actorId: actor.identifier, cardId: card.identifier)]
    }
}

class StayInJailExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .stayInJail = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.flipOverFirstDeckCard,
                .playerDiscardInPlay(actorId, cardId),
                .setTurn(state.nextTurn),
                .setChallenge(.startTurn)]
    }
}

class EscapeFromJailMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlay.filter({ $0.name == .dynamite }).isEmpty,
            let card = actor.inPlay.first(where: { $0.name == .jail }),
            let topDeckCard = state.deck.first,
            topDeckCard.makeEscapeFromJail else {
                return nil
        }
        
        return [GameMove(name: .escapeFromJail, actorId: actor.identifier, cardId: card.identifier)]
    }
}

class EscapeFromJailExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .escapeFromJail = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.flipOverFirstDeckCard,
                .playerDiscardInPlay(actorId, cardId)]
    }
}
