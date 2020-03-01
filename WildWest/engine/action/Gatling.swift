//
//  Gatling.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Gatling: PlayCardAtionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
            return []
        }
        
        let playersCount = state.players.count
        let targetIds = Array(1..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .setChallenge(.shoot(targetIds, .gatling, .byPlayer(actorId)))
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct GatlingRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .gatling) else {
                return nil
        }
        
        return cards.map { Gatling(actorId: actor.identifier, cardId: $0.identifier) }
    }
    
}
