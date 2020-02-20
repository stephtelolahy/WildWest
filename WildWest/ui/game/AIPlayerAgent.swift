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
    
    init(playerId: String, ai: AIProtocol, engine: GameEngineProtocol) {
        self.playerId = playerId
        self.ai = ai
        self.engine = engine
    }
    
    func start() {
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            guard state.validMoves.contains(where: { $0.actorId == self?.playerId }),
                let command = self?.ai.bestMove(in: state) else {
                    return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.engine.execute(command)
            }
        }))
    }
}
