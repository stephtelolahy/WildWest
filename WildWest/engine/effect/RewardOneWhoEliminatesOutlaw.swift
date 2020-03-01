//
//  RewardOneWhoEliminatesOutlaw.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct RewardOneWhoEliminatesOutlawRule: EffectRuleProtocol {
    
    func effectOnExecuting(action: ActionProtocol, in state: GameStateProtocol) -> ActionProtocol? {
        guard let eliminate = action as? Eliminate,
            let actor = state.eliminated.first(where: { $0.identifier == eliminate.actorId }),
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == actor.identifier,
            case let .byPlayer(offenderId) = damageEvent.source,
            state.players.contains(where: { $0.identifier == offenderId }),
            actor.role == .outlaw else {
                return nil
        }
        
        let description = "\(offenderId) gain 3 cards reward on eliminating outlaw"
        let updates: [GameUpdate] = [.playerPullFromDeck(offenderId, 3)]
        return Action(actorId: offenderId,
                      cardId: "",
                      autoPlay: true,
                      description: description,
                      updates: updates)
    }
}
