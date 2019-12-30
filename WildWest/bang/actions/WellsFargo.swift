//
//  WellsFargo.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// WellsFargo
/// “Draw three cards” from the top of the deck.
///
struct WellsFargo: ActionProtocol {
    let playerId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: playerId, cardId: cardId)
        state.pull(playerId: playerId)
        state.pull(playerId: playerId)
        state.pull(playerId: playerId)
    }
}

extension WellsFargo: RuleProtocol {
    
    static func match(playerId: String, state: GameStateProtocol) -> [ActionProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        let wellsFargoCards = player.hand.cards.filter { $0.name == .wellsFargo }
        return wellsFargoCards.map { Stagecoach(playerId: playerId, cardId: $0.identifier) }
    }
}
