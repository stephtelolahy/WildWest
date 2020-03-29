//
//  DiscardMissed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardMissedMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            (challenge.name == .bang || challenge.name == .gatling),
            let actor = state.players.first(where: { $0.identifier == challenge.targetIds?.first }),
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
            (challenge.name == .bang || challenge.name == .gatling),
            let actorId = move.actorId,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(challenge.removing(actorId))]
    }
}
