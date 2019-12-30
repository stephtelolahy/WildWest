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
    let playerId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: playerId, cardId: cardId)
        state.pull(playerId: playerId)
        state.pull(playerId: playerId)
    }
}

extension Stagecoach: RuleProtocol {
    
    static func match(playerId: String, state: GameStateProtocol) -> [ActionProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        let stagecoachCards = player.hand.cards.filter { $0.name == .stagecoach }
        return stagecoachCards.map { Stagecoach(playerId: playerId, cardId: $0.identifier) }
    }
}
