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
            let actorId = challenge.targetIds.first,
            let actor = state.player(actorId),
            let cards = actor.hand.filterOrNil({ actor.missedCardNames.contains($0.name) }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discardMissed, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardMissed = move.name,
            let challenge = state.challenge,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.setChallenge(challenge.countering(move.actorId)),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

extension MoveName {
    static let discardMissed = MoveName("discardMissed")
}
