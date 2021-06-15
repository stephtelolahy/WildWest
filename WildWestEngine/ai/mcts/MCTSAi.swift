//
//  MCTSAi.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 16/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

class MCTSAi: AIProtocol {
    
    func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove {
        MCTS().findBestMove(state: MCTSGameState(state: state))
    }
}

private class MCTSGameState: State {
    typealias Move = GMove
    
    private let state: GState
    
    init(state: StateProtocol) {
        self.state = GState(state)
    }
    
    var turn: Int {
        fatalError()
    }
    
    var status: Int {
        fatalError()
    }
    
    var possibleMoves: [GMove] {
        fatalError()
    }
    
    func performMove(_ move: GMove) -> Self {
        fatalError()
    }
}
