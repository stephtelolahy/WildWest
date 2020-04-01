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
            let actor = state.player(state.turn),
            let cards = actor.handCards(named: .generalStore) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .play, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .play = move.name,
            let cardId = move.cardId,
            let actor = state.player(move.actorId),
            let card = actor.handCard(cardId),
            case .generalStore = card.name else {
                return nil
        }
        
        return [.playerDiscardHand(move.actorId, cardId),
                .setupGeneralStore(state.players.count),
                .setChallenge(Challenge(name: .generalStore, targetIds: state.allPlayerIds(move.actorId)))]
    }
}
