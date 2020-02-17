//
//  AIPlayerAgent.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation
import RxSwift

class AIPlayerAgent: Subscribable {
    let engine: GameEngineProtocol
    let me: String
    let ai: AIProtocol
    
    init(engine: GameEngineProtocol, playerId: String, ai: AIProtocol) {
        self.engine = engine
        self.me = playerId
        self.ai = ai
    }
    
    func start() {
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            self?.processState(state)
        }))
    }
    
    private func processState(_ state: GameStateProtocol) {
        guard state.validMoves.contains(where: { $0.actorId == me }),
            let command = ai.bestMove(in: state) else {
                return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.engine.execute(command)
        }
    }
    
}
