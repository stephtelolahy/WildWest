//
//  Beer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Beer: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.discard(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
    }
}

extension Beer: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Beer]? {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .beer)
        guard !cards.isEmpty,
            state.players.count > 2,
            player.health < player.maxHealth else {
                return nil
        }
        
        return cards.map { Beer(actorId: player.identifier, cardId: $0.identifier) }
    }
}
