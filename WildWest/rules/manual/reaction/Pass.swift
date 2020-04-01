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
        case .bang, .gatling, .duel, .indians, .dynamiteExploded:
            return [GameMove(name: .pass, actorId: challenge.actorId(in: state)!)]
            
        default:
            return nil
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .pass = move.name,
            let challenge = state.challenge,
            let damageSource = challenge.damageSource(in: state) else {
                return nil
        }
        
        return [.playerLooseHealth(move.actorId, challenge.damage, damageSource),
                .setChallenge(challenge.removing(move.actorId))]
    }
}

extension MoveName {
    static let pass = MoveName("pass")
}
