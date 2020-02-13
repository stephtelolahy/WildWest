//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveJail: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let deckCard = state.deck.first else {
            return []
        }
        
        var updates: [GameUpdate] = []
        updates.append(.flipOverFirstDeckCard)
        updates.append(.playerDiscardInPlay(actorId, cardId))
        if deckCard.suit != .hearts {
            updates.append(.setTurn(state.nextTurn))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) resolves \(cardId)"
    }
}

struct ResolveJailRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .jail })  else {
                return nil
        }
        
        return [ResolveJail(actorId: actor.identifier, cardId: card.identifier)]
    }
}
