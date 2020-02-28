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
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == actorId }) else {
            return []
        }
        
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .playerSetHealth(actorId, player.health + 1)]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct BeerRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .beer),
            state.players.count > 2,
            actor.health < actor.maxHealth else {
                return nil
        }
        
        return cards.map { Beer(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
