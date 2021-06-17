//
//  RandomWithRoleAi.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 17/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

public class RandomWithRoleAi: AIProtocol {
    
    private let moveEvaluator: MoveEvaluatorProtocol
    
    public init (moveEvaluator: MoveEvaluatorProtocol) {
        self.moveEvaluator = moveEvaluator
    }
    
    public func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove {
        guard moves.count > 1 else {
            return moves[0]
        }
        
        var evaluatedMoves: [EvaluatedMove] = []
        var bestScore = Int.min
        moves.forEach { move in
            let score = moveEvaluator.evaluate(move, in: state)
            evaluatedMoves.append(EvaluatedMove(move: move, score: score))
            if score > bestScore {
                bestScore = score
            }
        }
        
        let bestMoves = evaluatedMoves.filter { $0.score == bestScore }
        return bestMoves.randomElement()!.move
    }
}

private struct EvaluatedMove {
    let move: GMove
    let score: Int
}
