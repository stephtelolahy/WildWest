//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol {
    
    let subjects: GameSubjectsProtocol
    
    private let delay: TimeInterval
    private let database: GameDatabaseProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    private let updateExecutor: UpdateExecutorProtocol
    
    private var currentLoop: GameLoopProtocol?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         subjects: GameSubjectsProtocol) {
        self.delay = delay
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.subjects = subjects
        
    }
    
    func startGame() {
        let moves = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        
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
                            moveMatchers: moveMatchers,
                            updateExecutor: updateExecutor,
                            subjects: subjects,
                            move: move,
                            completion: { [weak self] in self?.currentLoop = nil })
        currentLoop = loop
        loop.run()
    }
}
