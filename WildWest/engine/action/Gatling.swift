//
//  Gatling.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Gatling: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        guard let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
            return
        }
        
        let playersCount = state.players.count
        let targetIds = Array(1..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        state.setChallenge(.shoot(targetIds))
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct GatlingRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
            return nil
        }
        
        let cards = actor.handCards(named: .gatling)
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [Gatling(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
    
}
