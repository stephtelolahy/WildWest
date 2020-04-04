//
//  DiscardMissed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardMissedOnBangMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .bang = challenge.name,
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            let cards = actor.handCards(named: .missed) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            let challenge = state.challenge,
            case .bang = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.removing(move.actorId))]
    }
}

class DiscardMissedOnGatlingMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .gatling = challenge.name,
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            let cards = actor.handCards(named: .missed) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            let challenge = state.challenge,
            case .gatling = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.removing(move.actorId))]
    }
}