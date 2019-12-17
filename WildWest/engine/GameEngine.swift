//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/13/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameEngine {
    
    func run(state: GameStateProtocol) {
        let rules = [Beer.self]
        while state.outcome == nil {
            let playerId = state.players[state.turn].identifier
            let posssibleActions = rules.map { $0.match(playerId: playerId, state: state) }.flatMap { $0 }
            let action = posssibleActions[0]
            let updates = action.execute(state: state)
            updates.forEach { $0.apply(to: state) }
            print(state)
        }
    }
}
