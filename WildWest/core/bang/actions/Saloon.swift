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
    
    func execute(state: MutableGameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
        otherPlayerIds.forEach { state.gainLifePoint(playerId: $0) }
    }
}

extension Saloon: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [ActionProtocol] {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .saloon)
        let otherPlayerIds = state.players.filter({ $0.identifier != player.identifier }).map { $0.identifier }
        return cards.map { Saloon(actorId: player.identifier, cardId: $0.identifier, otherPlayerIds: otherPlayerIds) }
    }
}
