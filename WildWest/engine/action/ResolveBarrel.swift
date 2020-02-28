//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveBarrel: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let flippedCard = state.deck.first else {
            return []
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        if flippedCard.makeBarrelWorking {
            updates.append(.setChallenge(state.challenge?.removing(actorId)))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) uses \(cardId)"
    }
}

struct UseBarrelRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        let maxBarrels = 1
        guard case let .shoot(targetIds, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.inPlayCards(named: .barrel),
            state.barrelsResolved < maxBarrels else {
                return nil
        }
        
        return cards.map { ResolveBarrel(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
