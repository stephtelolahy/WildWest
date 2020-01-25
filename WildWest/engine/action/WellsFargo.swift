//
//  WellsFargo.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct WellsFargo: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
    }
    
    var message: String {
        "\(actorId) play \(cardId)"
    }
}

extension WellsFargo: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [WellsFargo] {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .wellsFargo)
        return cards.map { WellsFargo(actorId: player.identifier, cardId: $0.identifier) }
    }
}
