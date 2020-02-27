//
//  ResolveDynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveDynamite: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let flippedCard = state.deck.first else {
            return []
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        if flippedCard.makeDynamiteExplode {
            updates.append(.setChallenge(.startTurnDynamiteExploded))
            updates.append(.playerDiscardInPlay(actorId, cardId))
        } else {
            updates.append(.playerPassInPlayOfOther(actorId, state.nextTurn, cardId))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) resolves \(cardId)"
    }
}

struct ResolveDynamiteRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .dynamite })  else {
                return nil
        }
        
        return [ResolveDynamite(actorId: actor.identifier, cardId: card.identifier)]
    }
}
