//
//  Equip.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Equip: ActionProtocol, Equatable {
    
    let actorId: String
    let cardId: String
    
    func execute(state: GameStateProtocol) {
        guard let player = state.players.first(where: { $0.identifier == actorId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        if card.isGun,
            let currentGun = player.inPlay.cards.first(where: { $0.isGun }) {
            state.discardInPlay(playerId: actorId, cardId: currentGun.identifier)
        }
        
        state.putInPlay(playerId: actorId, cardId: cardId)
    }
    
    var description: String {
        "\(actorId) equip with \(cardId)"
    }
}

extension Equip: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [Equip] {
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
        return cards
            .filter { player.inPlayCards(named: $0.name).isEmpty }
            .map { Equip(actorId: player.identifier, cardId: $0.identifier) }
    }
}
