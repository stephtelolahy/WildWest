//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

/// Saloon
/// Cards with symbols on two lines have two simultaneous effects, one for each line.
/// Here symbols say: “Regain one life point”, and this applies to “All the other players”,
/// and on the next line: “[You] regain one life point”.
/// The overall effect is that all players in play regain one life point.
/// You cannot play a Saloon out of turn when you are losing
/// your last life point: the Saloon is not a Beer!
///
struct Saloon: ActionProtocol {
    let actorId: String
    let cardId: String
    let otherPlayerIds: [String]
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
        otherPlayerIds.forEach { state.gainLifePoint(playerId: $0) }
    }
}

extension Saloon: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let playerId = state.players[state.turn].identifier
        let otherPlayerIds = state.players.filter({ $0.identifier != playerId }).map { $0.identifier }
        let cards = state.matchingCards(playerId: playerId, cardName: .saloon)
        return cards.map { Saloon(actorId: playerId, cardId: $0.identifier, otherPlayerIds: otherPlayerIds) }
    }
}
