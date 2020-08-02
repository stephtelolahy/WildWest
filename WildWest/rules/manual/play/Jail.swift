//
//  Jail.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class JailMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .jail }) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { player in
            guard player.identifier != actor.identifier,
                player.role != .sheriff,
                !player.inPlay.contains(where: { $0.name == .jail }) else {
                    return false
            }
            return true
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            otherPlayers.map {
                GameMove(name: .jail, actorId: actor.identifier, cardId: card.identifier, targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .jail = move.name,
            let cardId = move.cardId,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerPutInPlayOfOther(move.actorId, targetId, cardId)]
    }
}

extension MoveName {
    static let jail = MoveName("jail")
}
