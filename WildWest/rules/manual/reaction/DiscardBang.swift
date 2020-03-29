//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBangOnDuelMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .duel = challenge.name,
            let actor = state.players.first(where: { $0.identifier == challenge.targetIds?.first }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            let challenge = state.challenge,
            case .duel = challenge.name,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(challenge.permutingTargets())]
    }
}

class DiscardBangOnIndiansMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .indians = challenge.name,
            let actor = state.players.first(where: { $0.identifier == challenge.targetIds?.first }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            let challenge = state.challenge,
            case .indians = challenge.name,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(challenge.removing(actorId))]
    }
}
