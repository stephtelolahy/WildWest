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
            let cards = actor.hand.filterOrNil({ $0.name == .dynamite }),
            !actor.inPlay.contains(where: { $0.name == .dynamite }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .dynamite, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .dynamite = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.playerPutInPlay(move.actorId, cardId)]
    }
}

extension MoveName {
    static let dynamite = MoveName("dynamite")
}
