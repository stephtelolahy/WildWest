//
//  Indians.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class IndiansMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .indians }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .play, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId),
            case .indians = card.name else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(Challenge(name: .indians, targetIds: state.otherPlayerIds(move.actorId)))]
    }
}
