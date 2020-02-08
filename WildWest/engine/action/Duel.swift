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
        "\(actorId) plays \(cardId) against \(targetId)"
    }
}

struct DuelRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }) else {
            return nil
        }
        
        let cards = actor.handCards(named: .duel)
        guard !cards.isEmpty else {
            return nil
        }
        
        let otherPlayers = state.players.filter { $0.identifier != actor.identifier }
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            let options = otherPlayers.map { Duel(actorId: actor.identifier,
                                                  cardId: card.identifier,
                                                  targetId: $0.identifier)
            }
            return GenericAction(name: card.name.rawValue,
                                 actorId: actor.identifier,
                                 cardId: card.identifier,
                                 options: options)
        }
    }
}
