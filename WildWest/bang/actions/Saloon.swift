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
    let playerId: String
    let cardId: String
    let otherPlayerIds: [String]
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: playerId, cardId: cardId)
        state.gainLifePoint(playerId: playerId)
        otherPlayerIds.forEach { state.gainLifePoint(playerId: $0) }
    }
}

extension Saloon: RuleProtocol {
    static func match(playerId: String, state: GameStateProtocol) -> [ActionProtocol] {
        guard let player = state.players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        let otherPlayerIds = state.players.filter({ $0.identifier != playerId }).map { $0.identifier }
        let sallonCards = player.hand.cards.filter { $0.name == .saloon }
        return sallonCards.map { Saloon(playerId: playerId, cardId: $0.identifier, otherPlayerIds: otherPlayerIds) }
    }
}
