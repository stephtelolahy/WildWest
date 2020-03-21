//
//  Jail.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class JailMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .jail) else {
                return nil
        }
        
        let otherPlayers = state.players.filter { player in
            guard player.identifier != actor.identifier,
                player.role != .sheriff,
                player.inPlayCards(named: .jail) == nil else {
                    return false
            }
            
            return true
        }
        
        guard !otherPlayers.isEmpty else {
            return nil
        }
        
        return cards.map { card in
            otherPlayers.map {
                GameMove(name: .play,
                         actorId: actor.identifier,
                         cardId: card.identifier,
                         cardName: card.name,
                         targetId: $0.identifier)
            }
        }.flatMap { $0 }
    }
}

class JailExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId,
            case .jail = move.cardName,
            let targetId = move.targetId else {
                return nil
        }
        
        return [.playerPutInPlayOfOther(actorId, targetId, cardId)]
    }
}
