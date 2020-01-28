//
//  EndTurn.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct EndTurn: ActionProtocol, Equatable {
    let actorId: String
    let cardsToDiscardIds: [String]
    
    func execute(state: GameStateProtocol) {
        cardsToDiscardIds.forEach { state.discardHand(playerId: actorId, cardId: $0) }
        let nextIndex = (state.turn + 1) % state.players.count
        state.setTurn(nextIndex)
    }
    
    var description: String {
        "\(actorId) end turn dropping \( cardsToDiscardIds.joined(separator: ","))"
    }
}

extension EndTurn: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [EndTurn] {
        guard state.challenge == nil else {
            return []
        }
        
        let player = state.players[state.turn]
        let cardsToDiscardIds = player.hand.cards.dropFirst(player.health).map { $0.identifier }
        return [EndTurn(actorId: player.identifier, cardsToDiscardIds: cardsToDiscardIds)]
    }
}
