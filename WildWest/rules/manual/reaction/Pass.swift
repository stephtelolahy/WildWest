//
//  Pass.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class PassMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        switch state.challenge {
        case let .shoot(targetIds, _, _):
            return [GameMove(name: .pass, actorId: targetIds.first)]
            
        case let .indians(targetIds, _):
            return [GameMove(name: .pass, actorId: targetIds.first)]
            
        case let .duel(playerIds, _):
            return [GameMove(name: .pass, actorId: playerIds.first)]
            
        case .dynamiteExploded:
            return [GameMove(name: .pass, actorId: state.turn)]
            
        default:
            return nil
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .pass = move.name,
            let actorId = move.actorId,
            let challenge = state.challenge,
            let damageSource = challenge.damageSource else {
                return nil
        }
        
        return [.playerLooseHealth(actorId, challenge.damage, damageSource),
                .setChallenge(challenge.removing(actorId))]
    }
}
