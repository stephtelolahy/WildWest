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
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId) else {
                return nil
        }
        
        let cards = actor.hand.filter { actor.missedCardNames.contains($0.name) }
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map {
            GameMove(name: .missed, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .missed = move.name,
            let challenge = state.challenge,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.countering(for: move.actorId))]
    }
}

extension MoveName {
    static let missed = MoveName("missed")
}
