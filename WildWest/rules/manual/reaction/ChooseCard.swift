//
//  ChooseCard.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class ChooseCardMatcher: MoveMatcherProtocol {
    
    func moves(matching state: GameStateProtocol) -> [GameMove]? {
        guard let challenge = state.challenge,
            case .generalStore = challenge.name,
            let actorId = challenge.targetIds.first else {
                return nil
        }
        
        return state.generalStore.map {
            GameMove(name: .choose, actorId: actorId, cardId: $0.identifier)
        }
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .choose = move.name,
            let challenge = state.challenge,
            let cardId = move.cardId else {
                return nil
        }
        
        return [.setChallenge(challenge.removing(move.actorId)),
                .playerPullFromGeneralStore(move.actorId, cardId)]
    }
}

extension MoveName {
    static let choose = MoveName("choose")
}
