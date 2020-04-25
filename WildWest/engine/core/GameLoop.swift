//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Foundation

class GameLoop: NSObject, GameLoopProtocol {
    
    private let delay: TimeInterval
    private let database: GameDatabaseProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    private let updateExecutor: UpdateExecutorProtocol
    private let subjects: GameSubjectsProtocol
    private var completion: (() -> Void)?
    private var pendingMoves: [GameMove]
    private var pendingUpdates: [GameUpdate]
    private var currentMove: GameMove?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         subjects: GameSubjectsProtocol,
         move: GameMove,
         completion: @escaping (() -> Void)) {
        self.delay = delay
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.subjects = subjects
        self.completion = completion
        pendingMoves = [move]
        pendingUpdates = []
    }
    
    func run() {
        //  ⚠️ Dispatch run to prevent RxSwift Reentrancy anomaly
        DispatchQueue.main.async { [weak self] in
            self?.processMove()
        }
    }
}

private extension GameLoop {
    
    func processMove() {
        guard !pendingMoves.isEmpty else {
            complete()
            return
        }
        
        let move = pendingMoves.remove(at: 0)
        currentMove = move
        
        #if DEBUG
        print("\n*** \(String(describing: move)) ***")
        #endif
        
        subjects.emitExecutedMove(move)
        subjects.emitValidMoves([])
        
        let updates = moveMatchers.compactMap({ $0.execute(move, in: database.state) }).flatMap { $0 }
        pendingUpdates.append(contentsOf: updates)
        
        #if DEBUG
        let sequence = updates.map({ String(format: "%.0f", $0.executionTime) }).joined(separator: "-")
        let warning = sequence.hasSuffix("-0") && sequence.contains("1")
        guard !warning else {
            fatalError("\n⚠️\(move.name.rawValue)\n\(sequence)")
        }
        #endif
        
        processUpdate()
    }
    
    func processUpdate() {
        guard !pendingUpdates.isEmpty else {
            postExecuteMove()
            return
        }
        
        let update = pendingUpdates.remove(at: 0)
        
        #if DEBUG
        print("> \(String(describing: update))")
        #endif
        
        subjects.emitExecutedUpdate(update)
        
        updateExecutor.execute(update, in: database)
        
        let waitDelay = pendingUpdates.isEmpty ? 0 : update.executionTime * delay
        schedule(after: waitDelay) { [weak self] in
            self?.processUpdate()
        }
    }
    
    func postExecuteMove() {
        guard let move = currentMove else {
            fatalError("Illegal state")
        }
        
        postExecute(move)
        
        schedule(after: delay) { [weak self] in
            self?.processMove()
        }
    }
    
    func postExecute(_ move: GameMove) {
        // emit game over
        if let outcome = database.state.claculateOutcome() {
            database.setOutcome(outcome)
            pendingMoves.removeAll()
            return
        }
        
        // queue effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            pendingMoves.append(contentsOf: effects)
            return
        }
        
        // wait until pendingMoves empty
        guard pendingMoves.isEmpty else {
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        if !autoPlays.isEmpty {
            pendingMoves.append(contentsOf: autoPlays)
            return
        }
    }
    
    func complete() {
        emitValidMoves()
        completion?()
    }
    
    func emitValidMoves() {
        guard database.state.outcome == nil else {
            return
        }
        
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: database.state) }.flatMap { $0 }
        let subjects = self.subjects
        // ⚠️ Dispatch emit valid moves after loop completed
        DispatchQueue.main.async {
            subjects.emitValidMoves(validMoves)
        }
    }
    
    func schedule(after waitDelay: TimeInterval, block: @escaping (() -> Void)) {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: waitDelay, repeats: false) { timer in
                timer.invalidate()
                block()
            }
        } else {
            block()
        }
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
