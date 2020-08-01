//
//  DiscardBeer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBeerMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            state.players.count > 2 else {
                return nil
        }
        
        var actorId: String?
        switch challenge.name {
        case .bang, .duel, .gatling, .indians, .generalStore:
            actorId = challenge.targetIds.first
            
        case .dynamiteExploded:
            actorId = state.turn
            
        default:
            return nil
        }
        
        guard let actor = state.player(actorId),
            actor.health <= challenge.damage,
            let beers = actor.hand.filterOrNil({ $0.name == .beer }) else {
                return nil
        }
        
        return beers.map {
            GameMove(name: .discardBeer, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discardBeer = move.name,
            let cardId = move.cardId,
            let challenge = state.challenge else {
                return nil
        }
        
        return [.setChallenge(challenge.decrementingDamage(move.actorId)),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

extension MoveName {
    static let discardBeer = MoveName("discardBeer")
}
