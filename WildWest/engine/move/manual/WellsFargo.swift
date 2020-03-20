//
//  WellsFargo.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class WellsFargoMatcher: ValidMoveMatcherProtocol {
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            let cards = actor.handCards(named: .wellsFargo) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .playCard,
                     actorId: actor.identifier,
                     cardId: $0.identifier,
                     cardName: $0.name)
        }
    }
}

class WellsFargoExecutor: MoveExecutorProtocol {
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .playCard = move.name,
            case .wellsFargo = move.cardName,
            let cardId = move.cardId,
            let actorId = move.actorId else {
                return nil
        }
        
        return [.playerDiscardHand(actorId, cardId),
                .playerPullFromDeck(actorId, 3)]
    }
}
