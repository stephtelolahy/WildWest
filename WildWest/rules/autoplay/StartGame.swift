//
//  StartGame.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class StartGameMatcher: MoveMatcherProtocol {
    
    func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        guard state.turn == nil else {
            return nil
        }
        
        return [GameMove(name: .startGame)]
    }
    
    func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        guard case .startGame = move.name,
            let sheriff = state.players.first(where: { $0.role == .sheriff }) else {
                return nil
        }
        
        return [.setTurn(sheriff.identifier),
                .setChallenge(.startTurn)]
    }
}

private extension MoveName {
    static let startGame = MoveName("startGame")
}
