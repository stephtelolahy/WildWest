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
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.gainLifePoint(playerId: actorId)
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct BeerRule: RuleProtocol {
    
    let actionName: String = "Beer"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let player = state.players[state.turn]
        let cards = player.handCards(named: .beer)
        guard !cards.isEmpty,
            state.players.count > 2,
            player.health < player.maxHealth else {
                return []
        }
        
        return cards.map { Beer(actorId: player.identifier, cardId: $0.identifier) }
    }
}
