//
//  Stagecoach.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Stagecoach
/// “Draw two cards” from the top of the deck.
///
struct Stagecoach: ActionProtocol {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.pull(playerId: actorId)
        state.pull(playerId: actorId)
    }
}

extension Stagecoach: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let playerId = state.players[state.turn].identifier
        let cards = state.matchingCards(playerId: playerId, cardName: .stagecoach)
        return cards.map { Stagecoach(actorId: playerId, cardId: $0.identifier) }
    }
}
