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
    private let moveMatchers: [MoveMatcherProtocol]
    
    private var currentLoop: GameLoopProtocol?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol]) {
        self.delay = delay
        self.database = database
        self.moveMatchers = moveMatchers
    }
    
    func start() {
        let state = database.state
        return moveMatchers
            .compactMap { $0.autoPlayMove(matching: state) }
            .forEach { execute($0) }
    }
    
    func execute(_ move: GameMove) {
        guard currentLoop == nil else {
            fatalError("Illegal state")
        }
        
        let loop = GameLoop(delay: delay,
                            database: database,
                            moveMatchers: moveMatchers,
                            move: move,
                            completion: { [weak self] in self?.currentLoop = nil })
        currentLoop = loop
        loop.run()
    }
}
