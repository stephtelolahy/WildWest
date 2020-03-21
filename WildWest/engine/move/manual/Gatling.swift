//
//  Gatling.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GatlingMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .gatling) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .play,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class GatlingExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let actorId = move.actorId,
            let cardId = move.cardId,
            let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
            return nil
        }
        
        let playersCount = state.players.count
        let targetIds = Array(1..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(.shoot(targetIds, .gatling, actorId))]
    }
}
