//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class BeerMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .beer }),
            state.players.count > 2,
            actor.health < actor.maxHealth else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .beer, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .beer = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        return [.playerSetHealth(move.actorId, actor.health + 1),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

extension MoveName {
    static let beer = MoveName("beer")
}
