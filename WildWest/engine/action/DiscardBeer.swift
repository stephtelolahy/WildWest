//
//  DiscardBeer.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardBeer: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    let cardsToDiscardIds: [String]
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = cardsToDiscardIds.map { .playerDiscardHand(actorId, $0) }
        if let challenge = state.challenge {
            updates.append(.setChallenge(challenge.removing(actorId)))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) discards \(cardsToDiscardIds.joined(separator: ", "))"
    }
}

struct DiscardBeerRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.players.count > 2 else {
            return nil
        }
        
        switch state.challenge {
        case let .shoot(targetIds, _):
            return matchDiscardBeer(actorId: targetIds[0], damage: 1, state: state)
            
        case let .indians(targetIds):
            return matchDiscardBeer(actorId: targetIds[0], damage: 1, state: state)
            
        case let .duel(playerIds):
            return matchDiscardBeer(actorId: playerIds[0], damage: 1, state: state)
            
        case .startTurnDynamiteExploded:
            return matchDiscardBeer(actorId: state.turn, damage: 3, state: state)
            
        default:
            return nil
        }
    }
    
    private func matchDiscardBeer(actorId: String, damage: Int, state: GameStateProtocol) -> [ActionProtocol]? {
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
        return [DiscardBeer(actorId: actorId, cardsToDiscardIds: cardsToDiscardIds)]
    }
    
}
