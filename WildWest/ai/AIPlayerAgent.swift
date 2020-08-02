//
//  AIPlayerAgent.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation
import RxSwift

protocol AIPlayerAgentProtocol {
    var playerId: String { get }
    
    func observeState()
}

class AIPlayerAgent: AIPlayerAgentProtocol, Subscribable {
    
    let playerId: String
    
    private let engine: GameEngineProtocol
    private let subjects: GameSubjectsProtocol
    private let ai: AIProtocol
    private let statsBuilder: StatsBuilderProtocol
    
    private var latestState: GameStateProtocol?
    
    init(playerId: String,
         ai: AIProtocol,
         engine: GameEngineProtocol,
         subjects: GameSubjectsProtocol,
         statsBuilder: StatsBuilderProtocol) {
        self.playerId = playerId
        self.ai = ai
        self.engine = engine
        self.subjects = subjects
        self.statsBuilder = statsBuilder
    }
    
    func observeState() {
        sub(subjects.state(observedBy: playerId).subscribe(onNext: { [weak self] state in
            self?.processState(state)
        }))
        
        sub(subjects.executedMove().subscribe(onNext: { [weak self] move in
            self?.processExecutedMove(move)
        }))
        
        sub(subjects.validMoves(for: playerId).subscribe(onNext: { [weak self] moves in
            self?.processValidMoves(moves)
        }))
    }
}

private extension AIPlayerAgent {
    
    func processState(_ state: GameStateProtocol) {
        latestState = state
    }
    
    func processExecutedMove(_ move: GameMove) {
        statsBuilder.updateScores(move)
    }
    
    func processValidMoves(_ moves: [GameMove]) {
        guard let state = latestState else {
            return
        }
        
        guard let move = ai.bestMove(among: moves, in: state) else {
            return
        }
        
        engine.execute(move)
    }
}
