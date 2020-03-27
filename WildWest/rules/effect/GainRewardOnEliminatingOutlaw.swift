//
//  GainRewardOnEliminatingOutlaw.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class GainRewardOnEliminatingOutlawMatcher: EffectMatcherProtocol {
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .eliminate = move.name,
            let actor = state.eliminated.first(where: { $0.identifier == move.actorId }),
            actor.role == .outlaw,
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == actor.identifier,
            case let .byPlayer(offenderId) = damageEvent.source,
            state.players.contains(where: { $0.identifier == offenderId }) else {
                return nil
        }
        
        return GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: offenderId)
    }
}

class GainRewardOnEliminatingOutlawExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .gainRewardOnEliminatingOutlaw = move.name,
            let actorId = move.actorId else {
            return nil
        }
        
        return [.playerPullFromDeck(actorId, 3)]
    }
}
