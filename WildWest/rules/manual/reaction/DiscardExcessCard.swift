//
//  DiscardExcessCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardExcessCardMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .discardExcessCards = challenge.name,
            let actor = state.players.first(where: { $0.identifier == challenge.actorId }) else {
                return nil
        }
        
        return actor.hand.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            let challenge = state.challenge,
            case .discardExcessCards = challenge.name,
            let cardId = move.cardId,
            let actor = state.players.first(where: { $0.identifier == move.actorId }) else {
                return nil
        }
        
        guard actor.health >= actor.hand.count - 1 else {
            return [.playerDiscardHand(actor.identifier, cardId)]
        }
        
        return [.playerDiscardHand(actor.identifier, cardId),
                .setTurn(state.nextTurn),
                .setChallenge(Challenge(name: .startTurn))]
    }
}
