//
//  RandomAIPreferPlay.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIPreferPlay: AIProtocol {
    
    func bestMove(in state: GameStateProtocol) -> ActionProtocol? {
        guard state.validMoves.count > 1 else {
            return state.validMoves.first
        }
        
        var evaluatedMoves: [EvaluatedMove] = []
        var bestScore = Int.min
        state.validMoves.forEach { move in
            let score = evaluate(move, in: state)
            evaluatedMoves.append(EvaluatedMove(move: move, score: score))
            if score > bestScore {
                bestScore = score
            }
        }
        
        let bestMoves = evaluatedMoves.filter { $0.score == bestScore }
        return bestMoves.randomElement()?.move
    }
    
    private func evaluate(_ move: ActionProtocol, in state: GameStateProtocol) -> Int {
        // prefer play instead of do nothing
        if move is EndTurn {
            return -1
        }
        
        // prefer reaction instead of do nothing
        if move is LooseLife {
            return -1
        }
        
        return 0
    }
    
    private struct EvaluatedMove {
        let move: ActionProtocol
        let score: Int
    }
    
}
