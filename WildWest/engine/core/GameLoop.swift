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
    
    @objc
    func processMove() {
        guard !pendingMoves.isEmpty else {
            complete()
            return
        }
        
        let move = pendingMoves.remove(at: 0)
        currentMove = move
        
//        print("\n*** \(String(describing: move)) ***")
        
        subjects.emitExecutedMove(move)
        subjects.emitValidMoves([])
        
        let updates = moveMatchers.compactMap({ $0.execute(move, in: database.state) }).flatMap { $0 }
        pendingUpdates.append(contentsOf: updates)
        
        let sequence = updates.map({ String(format: "%.0f", $0.executionTime) }).joined(separator: "-")
        let warning = sequence.hasSuffix("-0") ? "⚠️ " : ""
        print("\n\(warning)\(move.name.rawValue)\n\(sequence)")
        
        processUpdate()
    }
    
    @objc
    func processUpdate() {
        guard !pendingUpdates.isEmpty else {
            postExecuteMove()
            return
        }
        
        let update = pendingUpdates.remove(at: 0)
        
        //print("> \(String(describing: update))")
        
        subjects.emitExecutedUpdate(update)
        
        updateExecutor.execute(update, in: database)
        
        let waitDelay = pendingUpdates.isEmpty ? 0 : update.executionTime * delay
        perform(#selector(processUpdate), with: nil, afterDelay: waitDelay)
    }
    
    func postExecuteMove() {
        guard let move = currentMove else {
            fatalError("Illegal state")
        }
        
        postExecute(move)
        perform(#selector(processMove), with: nil, afterDelay: delay)
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
}

extension GameDatabaseProtocol {
    var state: GameStateProtocol {
        guard let value = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        return value
    }
}
