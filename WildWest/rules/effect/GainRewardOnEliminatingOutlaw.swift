//
//  GainRewardOnEliminatingOutlaw.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GainRewardOnEliminatingOutlawMatcher: MoveMatcherProtocol {
    
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .eliminate = move.name,
            let actor = state.eliminated.first(where: { $0.identifier == move.actorId }),
            actor.role == .outlaw,
            let damageEvent = actor.lastDamage,
            case let .byPlayer(offenderId) = damageEvent.source,
            state.players.contains(where: { $0.identifier == offenderId }) else {
                return nil
        }
        
        return GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: offenderId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .gainRewardOnEliminatingOutlaw = move.name else {
            return nil
        }
        
        return [.playerPullFromDeck(move.actorId, 3)]
    }
}

extension MoveName {
    static let gainRewardOnEliminatingOutlaw = MoveName("gainRewardOnEliminatingOutlaw")
}
