//
//  Saloon.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class SaloonMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .saloon),
            state.players.contains(where: { $0.health < $0.maxHealth }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .play,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            case .saloon = move.cardName,
            let cardId = move.cardId else {
                return nil
        }
        
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(move.actorId, cardId))
        let damagedPlayers = state.players.filter { $0.health < $0.maxHealth }
        damagedPlayers.forEach {
            updates.append(.playerGainHealth($0.identifier, 1))
        }
        return updates
    }    
}
