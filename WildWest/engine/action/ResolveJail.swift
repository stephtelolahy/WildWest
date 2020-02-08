//
//  ResolveJail.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct ResolveJail: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) {
        
    }
    
    var description: String {
        return "\(actorId) resolves \(cardId)"
    }
}

struct ResolveJailRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let card = actor.inPlay.first(where: { $0.name == .jail })  else {
                return nil
        }
        
        return [GenericAction(name: "resolve jail",
                              actorId: actor.identifier,
                              cardId: nil,
                              options: [ResolveJail(actorId: actor.identifier, cardId: card.identifier)])]
    }
}
