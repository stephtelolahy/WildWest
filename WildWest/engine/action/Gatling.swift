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
        "\(actorId) play \(cardId)"
    }
}

struct GatlingRule: RuleProtocol {
    
    let actionName: String = "Gatling"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .gatling)
        return cards.map { Gatling(actorId: actor.identifier, cardId: $0.identifier) }
    }
    
}