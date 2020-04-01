//
//  Dynamite.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class DynamiteMatcher: MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.handCards(named: .dynamite),
            actor.inPlayCards(named: .dynamite) == nil else {
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
            case .dynamite = card.name else {
                return nil
        }
        
        return [.playerPutInPlay(move.actorId, cardId)]
    }
}
