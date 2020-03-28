//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class UseBarrelMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        let maxBarrelsResolved = 1
        guard case let .shoot(targetIds, _, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            actor.inPlay.contains(where: { $0.name == .barrel }),
            state.barrelsResolved < maxBarrelsResolved,
            let topDeckCard = state.deck.first,
            topDeckCard.makeBarrelSuccessful else {
                return nil
        }
        
        return [GameMove(name: .useBarrel, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .useBarrel = move.name,
            let actorId = move.actorId else {
                return nil
        }
        
        return  [.flipOverFirstDeckCard,
                 .setChallenge(state.challenge?.removing(actorId))]
    }
}

class FailBarelMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        let maxBarrelsResolved = 1
        guard case let .shoot(targetIds, _, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            actor.inPlay.contains(where: { $0.name == .barrel }),
            state.barrelsResolved < maxBarrelsResolved,
            let topDeckCard = state.deck.first,
            !topDeckCard.makeBarrelSuccessful else {
                return nil
        }
        
        return [GameMove(name: .failBarrel, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .failBarrel = move.name else {
            return nil
        }
        
        return  [.flipOverFirstDeckCard]
    }
}

extension MoveName {
    static let useBarrel = MoveName("useBarrel")
    static let failBarrel = MoveName("failBarrel")
}
