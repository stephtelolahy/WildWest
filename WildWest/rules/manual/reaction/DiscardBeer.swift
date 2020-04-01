//
//  DiscardBeer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBeerMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            state.players.count > 2 else {
                return nil
        }
        
        var actorId: String?
        switch challenge.name {
        case .bang, .gatling, .duel, .indians, .dynamiteExploded:
            actorId = challenge.actorId(in: state)
            
        default:
            return nil
        }
        
        guard let actor = state.players.first(where: { $0.identifier == actorId }),
            (actor.health - challenge.damage) <= 0,
            let beers = actor.handCards(named: .beer) else {
                return nil
        }
        
        return beers.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        // Matching with challenge .bang is handle by DiscardMissedOnBangMatcher
        // Matching with challenge .gatling is handle by DiscardMissedOnGatlingMatcher
        // Matching with challenge .duel is handled by DiscardBangOnDuelMatcher
        // Matching with challenge .indians is handled by DiscardBangOnIndiansMatcher
        
        // Here is only matching with challenge .dynamiteExploded
        guard case .discard = move.name,
            let cardId = move.cardId,
            let challenge = state.challenge,
            case .dynamiteExploded = challenge.name else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.removingOneDamage(for: move.actorId))]
    }
}
