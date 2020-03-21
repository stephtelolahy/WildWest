//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DiscardBangOnDuelMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case let .duel(playerIds, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == playerIds.first }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class DiscardBangOnIndiansMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case let .indians(targetIds, _) = state.challenge,
            let actor = state.players.first(where: { $0.identifier == targetIds.first }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .discard,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class DiscardBangOnDuelExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            case .bang = move.cardName,
            case let .duel(playerIds, source) = state.challenge,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        let permutedPlayerIds = [playerIds[1], playerIds[0]]
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(.duel(permutedPlayerIds, source))]
    }
}

class DiscardBangOnIndiansExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .discard = move.name,
            case .bang = move.cardName,
            case .indians = state.challenge,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .setChallenge(state.challenge?.removing(actorId))]
    }
}
