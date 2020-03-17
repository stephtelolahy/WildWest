//
//  AIProtocol.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 15/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

protocol AIProtocol {
    func bestMove(among moves: [GameMove], in state: GameStateProtocol) -> GameMove?
    func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int
}

extension AIProtocol {
    func bestMove(among moves: [GameMove], in state: GameStateProtocol) -> GameMove? {
        guard moves.count > 1 else {
            return moves.first
        }
        
        var evaluatedMoves: [EvaluatedMove] = []
        var bestScore = Int.min
        moves.forEach { move in
            let score = evaluate(move, in: state)
            evaluatedMoves.append(EvaluatedMove(move: move, score: score))
            if score > bestScore {
                bestScore = score
            }
        }
        
        let bestMoves = evaluatedMoves.filter { $0.score == bestScore }
        return bestMoves.randomElement()?.move
    }
}

private struct EvaluatedMove {
    let move: GameMove
    let score: Int
}
