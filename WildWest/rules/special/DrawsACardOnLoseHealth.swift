//
//  DrawsACardOnLoseHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DrawsACardOnLoseHealthMatcher: MoveMatcherProtocol {
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        guard case .pass = move.name,
            let actor = state.player(move.actorId),
            actor.health > 0 else {
                return nil
        }
        
        return GameMove(name: .drawsACardOnLoseHealth, actorId: move.actorId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .drawsACardOnLoseHealth = move.name,
            let damageEvent = state.damageEvents.last,
            damageEvent.playerId == move.actorId else {
                return nil
        }
        
        return [.playerPullFromDeck(move.actorId, damageEvent.damage)]
    }
}

private extension DamageEvent {
    var damage: Int {
        switch source {
        case .byPlayer:
            return 1
        case .byDynamite:
            return 3
        }
    }
}

extension MoveName {
    static let drawsACardOnLoseHealth = MoveName("drawsACardOnLoseHealth")
}
