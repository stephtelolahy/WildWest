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
    let actorId: String
    let cardId: String
    
    func execute(state: MutableGameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.pull(playerId: actorId)
        state.pull(playerId: actorId)
        state.pull(playerId: actorId)
    }
}

extension WellsFargo: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .wellsFargo)
        return cards.map { Stagecoach(actorId: player.identifier, cardId: $0.identifier) }
    }
}
