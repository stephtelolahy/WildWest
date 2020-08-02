//
//  WellsFargo.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class WellsFargoMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .wellsFargo }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .wellsFargo, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .wellsFargo = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .playerPullFromDeck(move.actorId),
                .playerPullFromDeck(move.actorId),
                .playerPullFromDeck(move.actorId)]
    }
}

extension MoveName {
    static let wellsFargo = MoveName("wellsFargo")
}
