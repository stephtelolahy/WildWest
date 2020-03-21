//
//  PullGeneralStoreLastCardMatcher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class PullGeneralStoreLastCardMatcher: AutoplayMoveMatcherProtocol {
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard case let .generalStore(playerIds) = state.challenge,
            playerIds.count == 1,
            let actorId = playerIds.first else {
                return nil
        }
        
        return state.generalStore.map {
            GameMove(name: .choose, actorId: actorId, cardId: $0.identifier)
        }
    }
}
