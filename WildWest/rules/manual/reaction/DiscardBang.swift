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
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            let cards = actor.hand.filterOrNil({ $0.name == .bang }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discardBang, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardBang = move.name,
            let challenge = state.challenge,
            case .duel = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.swappingTargets())]
    }
}

class DiscardBangOnIndiansMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .indians = challenge.name,
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            let cards = actor.hand.filterOrNil({ $0.name == .bang }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discardBang, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardBang = move.name,
            let challenge = state.challenge,
            case .indians = challenge.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.countering(for: move.actorId))]
    }
}

extension MoveName {
    static let discardBang = MoveName("discardBang")
}
