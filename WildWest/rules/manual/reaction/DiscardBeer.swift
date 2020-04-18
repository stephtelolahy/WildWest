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
        
        guard let actor = state.player(actorId),
            (actor.health - challenge.damage) <= 0,
            let beers = actor.handCards(named: .beer) else {
                return nil
        }
        
        return beers.map {
            GameMove(name: .discard, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        // TODO: Matching with challenge .bang
        // TODO: Matching with challenge .gatling
        // TODO: Matching with challenge .duel
        // TODO: Matching with challenge .indians
        
        // Here is only matching with challenge .dynamiteExploded
        guard case .discard = move.name,
            let cardId = move.cardId,
            let challenge = state.challenge,
            case .dynamiteExploded = challenge.name else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setChallenge(challenge.decrementingDamage())]
    }
}
