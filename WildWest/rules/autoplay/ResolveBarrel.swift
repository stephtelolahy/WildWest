//
//  ResolveBarrel.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 05/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveBarrelMatcher: MoveMatcherProtocol {
    
    func autoPlay(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            (challenge.name == .bang || challenge.name == .gatling),
            let actorId = challenge.targetIds?.first,
            let actor = state.player(actorId),
            (challenge.barrelsPlayed ?? 0) < actor.barrelsCount else {
                return nil
        }
        
        let flippedCards = state.deck[0..<actor.flippedCardsCount]
        let moveName: MoveName = flippedCards.contains(where: { $0.makeBarrelSuccessful }) ? .useBarrel : .failBarrel
        
        return GameMove(name: moveName, actorId: actor.identifier)
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard move.name == .useBarrel || move.name == .failBarrel,
            let challenge = state.challenge,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        
        var updatedChallenge: Challenge? = challenge.incrementingBarrelsPlayed()
        if move.name == .useBarrel {
            updatedChallenge = updatedChallenge?.countering(move.actorId)
        }
        updates.append(.setChallenge(updatedChallenge))
        
        Array(1...actor.flippedCardsCount).forEach { _  in
            updates.append(.flipOverFirstDeckCard)
        }
        
        return updates
    }
}

extension MoveName {
    static let useBarrel = MoveName("useBarrel")
    static let failBarrel = MoveName("failBarrel")
}
