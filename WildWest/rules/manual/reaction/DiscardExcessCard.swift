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
            let actor = state.player(state.turn) else {
                return nil
        }
        
        return actor.hand.map {
            GameMove(name: .discardExcessCards, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardExcessCards = move.name,
            let challenge = state.challenge,
            case .discardExcessCards = challenge.name,
            let cardId = move.cardId,
            let actor = state.player(state.turn) else {
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

extension MoveName {
    static let discardExcessCards = MoveName("discardExcessCards")
}
