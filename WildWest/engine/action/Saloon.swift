//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Saloon: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        let damagedPlayers = state.players.filter { $0.health < $0.maxHealth }
        damagedPlayers.forEach { updates.append(.playerGainHealth($0.identifier, $0.health + 1)) }
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct SaloonRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .saloon) else {
                return nil
        }
        
        return cards.map { Saloon(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
