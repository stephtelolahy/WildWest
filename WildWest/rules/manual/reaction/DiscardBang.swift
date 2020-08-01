//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBangOnDuelMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .duel = challenge.name,
            let actorId = challenge.targetIds.first,
            let actor = state.player(actorId),
            let cards = actor.hand.filterOrNil({ $0.name == .bang }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discardBang, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardBang = move.name,
            let challenge = state.challenge,
            case .duel = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.setChallenge(challenge.swappingTargets()),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

class DiscardBangOnIndiansMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .indians = challenge.name,
            let actorId = challenge.targetIds.first,
            let actor = state.player(actorId),
            let cards = actor.hand.filterOrNil({ $0.name == .bang }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discardBang, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardBang = move.name,
            let challenge = state.challenge,
            case .indians = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.setChallenge(challenge.countering(move.actorId)),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

extension MoveName {
    static let discardBang = MoveName("discardBang")
}
