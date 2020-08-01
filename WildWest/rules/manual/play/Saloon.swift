//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class SaloonMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .saloon }),
            state.players.contains(where: { $0.health < $0.maxHealth }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .saloon, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .saloon = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        let damagedPlayers = state.players.filter { $0.health < $0.maxHealth }
        damagedPlayers.forEach {
            updates.append(.playerSetHealth($0.identifier, $0.health + 1))
        }
        updates.append(.playerDiscardHand(move.actorId, cardId))
        return updates
    }    
}

extension MoveName {
    static let saloon = MoveName("saloon")
}
