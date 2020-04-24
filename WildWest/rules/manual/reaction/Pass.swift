//
//  Pass.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

class PassMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge else {
            return nil
        }
        
        switch challenge.name {
        case .bang, .duel, .gatling, .indians, .generalStore:
            return [GameMove(name: .pass, actorId: challenge.targetIds.first!)]
            
        case .dynamiteExploded:
            return [GameMove(name: .pass, actorId: state.turn)]
            
        default:
            return nil
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .pass = move.name,
            let challenge = state.challenge,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var damageSource: DamageSource!
        switch challenge.name {
        case .bang, .gatling, .duel, .indians:
            damageSource = .byPlayer(state.turn)
            
        case .dynamiteExploded:
            damageSource = .byDynamite
            
        default:
            return nil
        }
        
        let health = max(actor.health - challenge.damage, 0)
        let damageEvent = DamageEvent(damage: challenge.damage, source: damageSource)
        return [.playerLooseHealth(move.actorId, health, damageEvent),
                .setChallenge(challenge.removing(move.actorId))]
    }
}

extension MoveName {
    static let pass = MoveName("pass")
}
