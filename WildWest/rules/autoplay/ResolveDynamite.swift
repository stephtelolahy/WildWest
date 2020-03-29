//
//  ResolveDynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ExplodeDynamiteMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .dynamite }),
            let topDeckCard = state.deck.first,
            topDeckCard.makeDynamiteExplode else {
                return nil
        }
        
        return [GameMove(name: .explodeDynamite, actorId: actor.identifier, cardId: card.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .explodeDynamite = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return  [.flipOverFirstDeckCard,
                 .setChallenge(Challenge(name: .dynamiteExploded)),
                 .playerDiscardInPlay(actorId, cardId)]
    }
}

class PassDynamiteMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .dynamite }),
            let topDeckCard = state.deck.first,
            !topDeckCard.makeDynamiteExplode else {
                return nil
        }
        
        return [GameMove(name: .passDynamite, actorId: actor.identifier, cardId: card.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .passDynamite = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return  [.flipOverFirstDeckCard,
                 .playerPassInPlayOfOther(actorId, state.nextTurn, cardId)]
    }
}

extension MoveName {
    static let explodeDynamite = MoveName("explodeDynamite")
    static let passDynamite = MoveName("passDynamite")
}
