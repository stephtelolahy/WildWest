//
//  Equip.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Equip: ActionProtocol {
    
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        state.equip(playerId: actorId, cardId: cardId)
    }
}

extension Equip: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Equip]? {
        let player = state.players[state.turn]
        let cards = player.handCards(named: .volcanic,
                                     .schofield,
                                     .remington,
                                     .winchester,
                                     .revCarbine,
                                     .barrel,
                                     .mustang,
                                     .scope,
                                     .dynamite)
        return cards.map { Equip(actorId: player.identifier, cardId: $0.identifier) }
    }
}
