//
//  Missed.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Missed: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.setChallenge(state.challenge?.removing(actorId))
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct MissedRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard case let .shoot(targetIds) = state.challenge else {
            return nil
        }
        
        guard let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.handCards(named: .missed) else {
                return nil
        }
        
        return cards.map { GenericAction(name: $0.name.rawValue,
                                         actorId: actor.identifier,
                                         cardId: $0.identifier,
                                         options: [Missed(actorId: actor.identifier, cardId: $0.identifier)])
        }
    }
}
