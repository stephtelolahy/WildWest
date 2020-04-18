//
//  DrawsCardOnLoseHealth.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DrawsCardOnLoseHealthMatcher: MoveMatcherProtocol {
    func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        switch move.name {
        case .pass:
            guard let actor = state.player(move.actorId),
                actor.abilities[.drawsCardOnLoseHealth] == true else {
                    return nil
            }
            
        case .explodeDynamite:
            guard let actor = state.player(move.actorId),
                actor.abilities[.drawsCardOnLoseHealth] == true,
                state.challenge?.name != .dynamiteExploded else {
                    return nil
            }
            
        default:
            return nil
        }
        
        return GameMove(name: .drawsCardOnLoseHealth, actorId: move.actorId)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .drawsCardOnLoseHealth = move.name,
            let actor = state.player(move.actorId),
            let damageEvent = actor.lastDamage else {
                return nil
        }
        
        return Array(1...damageEvent.damage).map { _ in .playerPullFromDeck(move.actorId) }
    }
}

extension MoveName {
    static let drawsCardOnLoseHealth = MoveName("drawsCardOnLoseHealth")
}
