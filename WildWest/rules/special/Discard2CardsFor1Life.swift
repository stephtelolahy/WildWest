//
//  Discard2CardsFor1Life.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class Discard2CardsFor1LifeMatcher: MoveMatcherProtocol {
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            actor.health < actor.maxHealth,
            actor.abilities[.canDiscard2CardsFor1Life] == true,
            actor.hand.count >= 2 else {
                return nil
        }
        
        let cardCombinations = actor.hand.map { $0.identifier }.combine(by: 2)
        
        return cardCombinations.map {
            GameMove(name: .discard2CardsFor1Life, actorId: actor.identifier, discardIds: $0)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard2CardsFor1Life = move.name,
            let discardIds = move.discardIds,
            let actor = state.player(move.actorId) else {
                return nil
        }
        
        var updates: [GameUpdate] = [.playerSetHealth(move.actorId, actor.health + 1)]
        discardIds.forEach { updates.append(.playerDiscardHand(move.actorId, $0)) }
        return updates
    }
}

extension MoveName {
    static let discard2CardsFor1Life = MoveName("discard2CardsFor1Life")
}
