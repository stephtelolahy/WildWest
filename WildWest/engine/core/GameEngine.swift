//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol {
    
    private let delay: TimeInterval
    private let database: GameDatabaseProtocol
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let moveMatchers: [MoveMatcherProtocol]
    private let updateExecutor: UpdateExecutorProtocol
    
    private var currentLoop: GameLoopProtocol?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         stateSubject: BehaviorSubject<GameStateProtocol>,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         subjects: GameSubjectsProtocol) {
        self.delay = delay
        self.database = database
        self.stateSubject = stateSubject
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
    }
    
    func startGame() {
        let moves = moveMatchers.compactMap { $0.autoPlayMove(matching: state) }
        
        guard moves.count == 1 else {
            fatalError("Illegal state")
        }
        
        execute(moves[0])
    }
    
    func execute(_ move: GameMove) {
        guard currentLoop == nil else {
            fatalError("Illegal state")
        }
        
        let loop = GameLoop(delay: delay,
                            database: database,
                            stateSubject: stateSubject,
                            moveMatchers: moveMatchers,
                            updateExecutor: updateExecutor,
                            move: move,
                            completion: { [weak self] in self?.currentLoop = nil })
        currentLoop = loop
        loop.run()
    }
}

private extension GameEngine {
    var state: GameStateProtocol {
        guard let value = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        return value
    }
}