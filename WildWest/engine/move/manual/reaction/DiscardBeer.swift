//
//  DiscardBeer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBeerMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.players.count > 2 else {
            return nil
        }
        
        switch state.challenge {
        case let .shoot(targetIds, _, _):
            return matchDiscardBeer(actorId: targetIds.first, damage: 1, in: state)
            
        case let .indians(targetIds, _):
            return matchDiscardBeer(actorId: targetIds.first, damage: 1, in: state)
            
        case let .duel(playerIds, _):
            return matchDiscardBeer(actorId: playerIds.first, damage: 1, in: state)
            
        case .dynamiteExploded:
            return matchDiscardBeer(actorId: state.turn, damage: 3, in: state)
            
        default:
            return nil
        }
    }
    
    private func matchDiscardBeer(actorId: String?, damage: Int, in state: GameStateProtocol) -> [GameMove]? {
        guard let actor = state.players.first(where: { $0.identifier == actorId }) else {
            return nil
        }
        
        let willBeEliminated = actor.health - damage <= 0
        guard willBeEliminated else {
            return nil
        }
        
        let requiredBeers = damage - actor.health + 1
        guard let cards = actor.handCards(named: .beer),
            cards.count >= requiredBeers else {
                return nil
        }
        
        let cardsToDiscardIds = cards.prefix(requiredBeers).map { $0.identifier }
        return [GameMove(name: .discard,
                         actorId: actorId,
                         cardName: .beer,
                         discardIds: cardsToDiscardIds)]
    }
}

class DiscardBeerExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            case .beer = move.cardName,
            let actorId = move.actorId,
            let cardsToDiscardIds = move.discardIds else {
                return nil
        }
        
        var updates: [GameUpdate] = cardsToDiscardIds.map { .playerDiscardHand(actorId, $0) }
        updates.append(.setChallenge(state.challenge?.removing(actorId)))
        return updates
    }
}
