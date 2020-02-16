//
//  RandomAI.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct EvaluatedMove {
    let move: ActionProtocol
    let score: Int
}

class RandomAI: AIProtocol {
    func bestMove(in state: GameStateProtocol) -> ActionProtocol? {
        let activePlayers = Set(state.actions.map { $0.actorId })
        assert(activePlayers.count == 1)
        
        return state.actions.randomElement()
    }
}
