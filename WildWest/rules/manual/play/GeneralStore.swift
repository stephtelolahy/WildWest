//
//  GeneralStore.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/31/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GeneralStoreMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.challenge == nil,
            let actor = state.player(state.turn),
            let cards = actor.hand.filterOrNil({ $0.name == .generalStore }) else {
                return nil
        }
        
        return cards.map {
            GameMove(name: .generalStore, actorId: actor.identifier, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .generalStore = move.name,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.setChallenge(Challenge(name: .generalStore, targetIds: state.allPlayerIds(move.actorId))),
                .setupGeneralStore(state.players.count),
                .playerDiscardHand(move.actorId, cardId)]
    }
}

extension MoveName {
    static let generalStore = MoveName("generalStore")
}
