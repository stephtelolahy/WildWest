//
//  Pass.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class PassMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge else {
            return nil
        }
        
        switch challenge.name {
        case .bang, .gatling, .duel, .indians:
            return [GameMove(name: .pass, actorId: challenge.targetIds?.first)]
            
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

extension MoveName {
    static let pass = MoveName("pass")
}
