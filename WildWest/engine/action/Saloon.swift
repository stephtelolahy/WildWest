//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Saloon: ActionProtocol {
    let actorId: String
    let cardId: String
    let otherPlayerIds: [String]
    
    func execute(state: MutableGameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
        otherPlayerIds.forEach { state.gainLifePoint(playerId: $0) }
    }
}

extension Saloon: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol]? {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .saloon)
        let otherPlayerIds = state.players.filter({ $0.identifier != player.identifier }).map { $0.identifier }
        return cards.map { Saloon(actorId: player.identifier, cardId: $0.identifier, otherPlayerIds: otherPlayerIds) }
    }
}
