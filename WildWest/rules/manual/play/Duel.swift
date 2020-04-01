//
//  Duel.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class DuelMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .duel) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
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
            case .duel = move.cardName,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(Challenge(name: .duel, targetIds: [targetId, move.actorId]))]
    }
}
