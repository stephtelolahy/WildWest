//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StayInJailMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlay.filter({ $0.name == .dynamite }).isEmpty,
            let card = actor.inPlay.first(where: { $0.name == .jail }),
            let topDeckCard = state.deck.first,
            !topDeckCard.makeEscapeFromJail else {
                return nil
        }
        
        return [GameMove(name: .stayInJail, actorId: actor.identifier, cardId: card.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .stayInJail = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.flipOverFirstDeckCard,
                .playerDiscardInPlay(move.actorId, cardId),
                .setTurn(state.nextTurn),
                .setChallenge(Challenge(name: .startTurn))]
    }
}

class EscapeFromJailMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlay.filter({ $0.name == .dynamite }).isEmpty,
            let card = actor.inPlay.first(where: { $0.name == .jail }),
            let topDeckCard = state.deck.first,
            topDeckCard.makeEscapeFromJail else {
                return nil
        }
        
        return [GameMove(name: .escapeFromJail, actorId: actor.identifier, cardId: card.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .escapeFromJail = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.flipOverFirstDeckCard,
                .playerDiscardInPlay(move.actorId, cardId)]
    }
}

extension MoveName {
    static let stayInJail = MoveName("stayInJail")
    static let escapeFromJail = MoveName("escapeFromJail")
}
