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
            let actor = state.player(state.turn),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        let bangLimits = actor.bangLimitsPerTurn
        guard bangLimits == 0 || state.bangsPlayed < bangLimits  else {
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
                GameMove(name: .play,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         cardName: card.name,
                         targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            case .bang = move.cardName,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(Challenge(name: .bang, targetIds: [targetId]))]
    }
}
