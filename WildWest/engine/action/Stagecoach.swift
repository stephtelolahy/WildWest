//
//  Stagecoach.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Stagecoach: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct StagecoachRule: RuleProtocol {
    
    let actionName: String = "Stagecoach"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .stagecoach)
        return cards.map { Stagecoach(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
