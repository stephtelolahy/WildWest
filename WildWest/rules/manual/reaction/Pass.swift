//
//  Pass.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class PassMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge else {
            return nil
        }
        
        switch challenge.name {
        case .bang, .duel, .gatling, .indians:
            guard let actorId = challenge.targetIds?.first else {
                return nil
            }
            return [GameMove(name: .pass, actorId: actorId)]
            
        case .dynamiteExploded:
            return [GameMove(name: .pass, actorId: state.turn)]
            
        default:
            return nil
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .pass = move.name,
            let challenge = state.challenge,
            let actor = state.player(move.actorId),
            let damage = challenge.damage else {
                return nil
        }
        
        let damageSource: DamageSource
        switch challenge.name {
        case .bang, .duel, .gatling, .indians:
            damageSource = .byPlayer(state.turn)
            
        case .dynamiteExploded:
            damageSource = .byDynamite
            
        default:
            return nil
        }
        
        let health = max(actor.health - damage, 0)
        let damageEvent = DamageEvent(damage: damage, source: damageSource)
        return [.setChallenge(challenge.removing(move.actorId)),
                .playerSetDamage(move.actorId, damageEvent),
                .playerSetHealth(move.actorId, health)]
    }
}

extension MoveName {
    static let pass = MoveName("pass")
}
