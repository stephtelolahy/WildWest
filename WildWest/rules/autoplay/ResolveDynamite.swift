//
//  ResolveDynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ResolveDynamiteMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard let challenge = state.challenge,
            case .startTurn = challenge.name,
            let actor = state.player(state.turn),
            let card = actor.inPlay.first(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        let flippedCards = state.deck[0..<actor.flippedCardsCount]
        let moveName: MoveName =
            flippedCards.contains(where: { !$0.makeDynamiteExplode }) ? .passDynamite : .dynamiteExploded
        
        return GameMove(name: moveName, actorId: actor.identifier, cardId: card.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        switch move.name {
        case .dynamiteExploded:
            return executeDynamiteExploded(move, in: state)
            
        case .passDynamite:
            return executePassDynamite(move, in: state)
            
        default:
            return nil
        }
    }
    
    private func executeDynamiteExploded(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard let actor = state.player(move.actorId),
            let cardId = move.cardId else {
                return nil
        }
        
        var updates: [GameUpdate] = Array(1...actor.flippedCardsCount).map { _ in .flipOverFirstDeckCard }
        
        let dynamiteDamage = 3
        let immediateDamage = actor.health <= dynamiteDamage ? actor.health - 1 : dynamiteDamage
        if immediateDamage > 0 {
            updates.append(.playerLooseHealth(actor.identifier, immediateDamage, .byDynamite))
        }
        
        let remainingDamage = dynamiteDamage - immediateDamage
        if remainingDamage > 0 {
            updates.append(.setChallenge(Challenge(name: .dynamiteExploded, damage: remainingDamage)))
        }
        
        updates.append(.playerDiscardInPlay(move.actorId, cardId))
        
        return updates
    }
    
    private func executePassDynamite(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard let actor = state.player(move.actorId),
            let cardId = move.cardId else {
            return nil
        }
        
        var updates: [GameUpdate] = Array(1...actor.flippedCardsCount).map { _ in .flipOverFirstDeckCard }
        
        updates.append(.playerPassInPlayOfOther(move.actorId, state.nextPlayer(after: move.actorId), cardId))
        
        return updates
    }
}

extension MoveName {
    static let passDynamite = MoveName("passDynamite")
    static let dynamiteExploded = MoveName("dynamiteExploded")
}
