//
//  AI.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 06/11/2020.
//

public protocol AIProtocol {
    func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove
}

public class GAI: AIProtocol {
    
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
