//
//  StartGame.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartGameMatcher: MoveMatcherProtocol {
    
    func autoPlayMove(matching state: GameStateProtocol) -> GameMove? {
        guard state.turn == nil,
            let sheriff = state.players.first(where: { $0.role == .sheriff }) else {
                return nil
        }
        
        return GameMove(name: .startGame, actorId: sheriff.identifier)
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .startGame = move.name else {
            return nil
        }
        
        return [.setTurn(move.actorId),
                .setChallenge(Challenge(name: .startTurn))]
    }
}

extension MoveName {
    static let startGame = MoveName("startGame")
}
