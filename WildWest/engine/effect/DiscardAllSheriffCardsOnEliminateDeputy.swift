//
//  DiscardAllSheriffCardsOnEliminateDeputy.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardAllSheriffCardsOnEliminateDeputy: EffectRuleProtocol {
    
    func effectOnExecuting(action: ActionProtocol, in state: GameStateProtocol) -> ActionProtocol? {
        guard let eliminate = action as? Eliminate,
            let actor = state.eliminated.first(where: { $0.identifier == eliminate.actorId }),
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == actor.identifier,
            case let .byPlayer(offenderId) = damageEvent.source,
            let offender = state.players.first(where: { $0.identifier == offenderId }),
            actor.role == .deputy,
            offender.role == .sheriff else {
                return nil
        }
        
        let description = "\(offenderId) loose all cards on eliminating his deputy"
        var updates: [GameUpdate] = []
        offender.hand.forEach { updates.append(.playerDiscardHand(offenderId, $0.identifier)) }
        offender.inPlay.forEach { updates.append(.playerDiscardInPlay(offenderId, $0.identifier)) }
        
        return Action(actorId: offenderId,
                      autoPlay: true,
                      description: description,
                      updates: updates)
    }
}
