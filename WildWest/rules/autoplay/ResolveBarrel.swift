//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class UseBarrelMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            (challenge.name == .bang || challenge.name == .gatling),
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            challenge.barrelsResolved < actor.barrelsCount,
            let topDeckCard = state.deck.first,
            topDeckCard.makeBarrelSuccessful else {
                return nil
        }
        
        return [GameMove(name: .useBarrel, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .useBarrel = move.name,
            let challenge = state.challenge else {
                return nil
        }
        
        return  [.flipOverFirstDeckCard,
                 .setChallenge(challenge.removing(move.actorId))]
    }
}

class FailBarelMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            (challenge.name == .bang || challenge.name == .gatling),
            let actorId = challenge.actorId(in: state),
            let actor = state.player(actorId),
            challenge.barrelsResolved < actor.barrelsCount,
            let topDeckCard = state.deck.first,
            !topDeckCard.makeBarrelSuccessful else {
                return nil
        }
        
        return [GameMove(name: .failBarrel, actorId: actor.identifier)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .failBarrel = move.name,
            let challenge = state.challenge else {
                return nil
        }
        
        return  [.flipOverFirstDeckCard,
                 .setChallenge(challenge.incrementingBarrelsResolved())]
    }
}

extension MoveName {
    static let useBarrel = MoveName("useBarrel")
    static let failBarrel = MoveName("failBarrel")
}
