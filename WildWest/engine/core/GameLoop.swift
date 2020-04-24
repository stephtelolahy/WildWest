//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameLoop: GameLoopProtocol {
    
    private let delay: TimeInterval
    private let database: GameDatabaseProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    private let updateExecutor: UpdateExecutorProtocol
    private let gameSubjects: GameSubjectsProtocol
    
    private var running: Bool
    private var pendingMoves: [GameMove]
    private var pendingUpdates: [GameUpdate]
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         gameSubjects: GameSubjectsProtocol) {
        self.delay = delay
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.gameSubjects = gameSubjects
        running = false
        pendingMoves = []
        pendingUpdates = []
    }
    
    // MARK: GameLoopProtocol
    
    func execute(move: GameMove) {
        guard !running,
            pendingMoves.isEmpty,
            pendingUpdates.isEmpty else {
                fatalError("Illegal state")
        }
        
        pendingMoves.append(move)
        start()
    }
}

private extension GameLoop {
    
    func start() {
        running = true
        processMove()
    }
    
    func processMove() {
        guard !pendingMoves.isEmpty else {
            stop()
            return
        }
        
        let move = pendingMoves[0]
        
        print("\n*** \(String(describing: move)) ***")
        
        gameSubjects.emitExecutedMove(move)
        gameSubjects.emitValidMoves([])
        
        let updates = moveMatchers.compactMap({ $0.execute(move, in: database.state) }).flatMap { $0 }
        pendingUpdates.append(contentsOf: updates)
        
        processUpdate()
    }
    
    func processUpdate() {
        guard !pendingUpdates.isEmpty else {
            postProcessMove()
            return
        }
        
        let update = pendingUpdates.remove(at: 0)
        
        print("> \(String(describing: update))")
        
        gameSubjects.emitExecutedUpdate(update)
        
        updateExecutor.execute(update, in: database)
        
        let waitDelay = update.executionTime * delay
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitDelay) { [weak self] in
            self?.processUpdate()
        }
    }
    
    func postProcessMove() {
        let move = pendingMoves.remove(at: 0)
        
        // emit game over
        if let outcome = database.state.claculateOutcome() {
            database.setOutcome(outcome)
            stop()
            return
        }
        
        // queue effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            pendingMoves.append(contentsOf: effects)
            processMove()
            return
        }
        
        // wait until all pendingMoves empty
        guard pendingMoves.isEmpty else {
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        if !autoPlays.isEmpty {
            pendingMoves.append(contentsOf: autoPlays)
            processMove()
            return
        }
        
        // wait until all pendingMoves empty
        guard pendingMoves.isEmpty else {
            return
        }
        
        // emit valid moves
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: database.state) }.flatMap { $0 }
        gameSubjects.emitValidMoves(validMoves)
    }
    
    func stop() {
        running = false
    }
}

extension GameDatabaseProtocol {
    var state: GameStateProtocol {
        guard let value = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        return value
    }
}
