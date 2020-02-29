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
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [
            .playerDiscardHand(actorId, cardId),
            .setChallenge(state.challenge?.removing(actorId))
        ]
        return updates
    }
    
    var description: String {
        "\(actorId) plays \(cardId)"
    }
}

struct MissedRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard case let .shoot(targetIds, _, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.handCards(named: .missed) else {
                return nil
        }
        
        return cards.map { Missed(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
