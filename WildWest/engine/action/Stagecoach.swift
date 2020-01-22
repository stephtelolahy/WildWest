//
//  Stagecoach.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

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
    
    static func match(state: GameStateProtocol) -> [ActionProtocol]? {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .stagecoach)
        return cards.map { Stagecoach(actorId: player.identifier, cardId: $0.identifier) }
    }
}
