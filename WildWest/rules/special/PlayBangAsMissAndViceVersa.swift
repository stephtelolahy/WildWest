//
//  PlayBangAsMissAndViceVersa.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 04/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class BangWithMissedMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            actor.abilities[.canPlayBangAsMissAndViceVersa] == true,
            let cards = actor.handCards(named: .missed) else {
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
                GameMove(name: .bangWithMissed,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .bangWithMissed = move.name,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(Challenge(name: .bang, targetIds: [targetId]))]
    }
}

class MissWithBangMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            (challenge.name == .bang || challenge.name == .gatling),
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            actor.abilities[.canPlayBangAsMissAndViceVersa] == true,
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
}

extension MoveName {
    static let bangWithMissed = MoveName("bangWithMissed")
}
