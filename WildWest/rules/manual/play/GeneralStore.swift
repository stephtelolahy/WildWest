//
//  GeneralStore.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GeneralStoreMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .generalStore) else {
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
            case .generalStore = move.cardName,
            let actorId = move.actorId,
            let cardId = move.cardId,
            let actorIndex = state.players.firstIndex(where: { $0.identifier == actorId }) else {
                return nil
        }
        
        let playersCount = state.players.count
        let playerIds = Array(0..<playersCount).map { state.players[(actorIndex + $0) % playersCount].identifier }
        return [.playerDiscardHand(actorId, cardId),
                .setupGeneralStore(playersCount),
                .setChallenge(Challenge(name: .generalStore, actorId: actorId, targetIds: playerIds))]
    }
}
