//
//  Gatling.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GatlingMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .gatling }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .gatling, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .gatling = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        let challenge = Challenge(name: .gatling, targetIds: state.otherPlayerIds(move.actorId))
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge)]
    }
}

extension MoveName {
    static let gatling = MoveName("gatling")
}
