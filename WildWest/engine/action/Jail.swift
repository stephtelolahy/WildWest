//
//  Jail.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

struct Jail: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let targetId: String
    
    func execute(in state: GameStateProtocol) {
        state.putInJail(playerId: actorId, cardId: cardId, targetId: targetId)
    }
    
    var description: String {
        "\(actorId) put \(targetId) in jail"
    }
}

struct JailRule: RuleProtocol {
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .jail) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { player in
            guard player.identifier != actor.identifier,
                player.role != .sheriff,
                player.inPlayCards(named: .jail).isEmpty else {
                    return false
            }
            
            return true
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            let options = otherPlayers.map { Jail(actorId: actor.identifier,
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
