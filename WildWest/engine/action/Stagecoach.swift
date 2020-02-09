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
        state.pullDeck(playerId: actorId)
        state.pullDeck(playerId: actorId)
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct StagecoachRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
                return nil
        }
        
        let cards = actor.handCards(named: .stagecoach)
        guard !cards.isEmpty else {
            return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [Stagecoach(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
