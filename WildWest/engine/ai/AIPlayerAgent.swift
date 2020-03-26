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
    func start()
}

class AIPlayerAgent: AIPlayerAgentProtocol, Subscribable {
    let engine: GameEngineProtocol
    let playerId: String
    let ai: AIProtocol
    let delay: Double
    
    init(playerId: String, ai: AIProtocol, engine: GameEngineProtocol, delay: Double) {
        self.playerId = playerId
        self.ai = ai
        self.engine = engine
        self.delay = delay
    }
    
    func start() {
        sub(engine.observeAs(playerId: playerId).subscribe(onNext: { [weak self] state in
            self?.processState(state)
        }))
    }
    
    private func processState(_ state: GameStateProtocol) {
        guard let moves = state.validMoves[playerId],
            let move = ai.bestMove(among: moves, in: state) else {
                return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.engine.queue(move)
        }
    }
}
