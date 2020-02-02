//
//  Duel.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Duel: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let targetId: String
    
    func execute(in state: GameStateProtocol) {
        state.discardHand(playerId: actorId, cardId: cardId)
        state.setChallenge(.duel([targetId, actorId]))
    }
    
    var description: String {
        "\(actorId) play \(cardId)"
    }
}

struct DuelRule: RuleProtocol {
    
    let actionName: String = "Duel"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard state.challenge == nil else {
            return []
        }
        
        let actor = state.players[state.turn]
        let cards = actor.handCards(named: .duel)
        guard !cards.isEmpty else {
            return []
        }
        
        var result: [Duel] = []
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
        for card in cards {
            for otherPlayer in otherPlayers {
                result.append(Duel(actorId: actor.identifier,
                                   cardId: card.identifier,
                                   targetId: otherPlayer.identifier))
            }
        }
        
        return result
    }
}
