//
//  Bang.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class BangMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn) else {
                return nil
        }
        
        let cards = actor.hand.filter { actor.bandCardNames.contains($0.name) }
        guard !cards.isEmpty else {
            return nil
        }
        
        let bangLimits = actor.bangLimitsPerTurn
        guard bangLimits == 0 || actor.bangsPlayed < bangLimits  else {
            return nil
        }
        
        let otherPlayers = state.players.filter {
            $0.identifier != actor.identifier
                && state.distance(from: actor.identifier, to: $0.identifier) <= actor.gunRange
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            otherPlayers.map {
                GameMove(name: .bang, actorId: actor.identifier, cardId: card.identifier, targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .bang = move.name,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(Challenge(name: .bang, targetIds: [targetId]))]
    }
}

extension MoveName {
    static let bang = MoveName("bang")
}
