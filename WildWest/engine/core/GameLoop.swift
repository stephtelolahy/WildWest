//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameLoop: NSObject, GameLoopProtocol, Subscribable {
    
    private let delay: TimeInterval
    private let database: GameDatabaseProtocol
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let moveMatchers: [MoveMatcherProtocol]
    private let updateExecutor: UpdateExecutorProtocol
    private var completion: (() -> Void)?
    private var pendingMoves: [GameMove]
    private var pendingUpdates: [GameUpdate]
    private var currentMove: GameMove?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         stateSubject: BehaviorSubject<GameStateProtocol>,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         move: GameMove,
         completion: @escaping (() -> Void)) {
        self.delay = delay
        self.database = database
        self.stateSubject = stateSubject
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
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
        
        database.setExecutedMove(move)
        database.setValidMoves([])
        
        let updates = moveMatchers.compactMap({ $0.execute(move, in: state) }).flatMap { $0 }
        pendingUpdates.append(contentsOf: updates)
        
        #if DEBUG
        let sequence = updates.map({ String(format: "%.0f", $0.executionTime) }).joined(separator: "-")
        let warning = sequence.hasSuffix("-0") && sequence.contains("1")
        guard !warning else {
            fatalError("Invalid update sequence \(move.name.rawValue): \(sequence)")
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
        
        database.setExecutedUpdate(update)
        
        sub(updateExecutor.execute(update, in: database).subscribe(onCompleted: { [ weak self] in
            self?.wait(afterExecuting: update)
            }, onError: { error in
                fatalError(error.localizedDescription)
        }))
    }
    
    func wait(afterExecuting update: GameUpdate) {
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
        if let outcome = state.claculateOutcome() {
            sub(database.setOutcome(outcome).subscribe())
            pendingMoves.removeAll()
            return
        }
        
        // queue effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: state) }
        if !effects.isEmpty {
            pendingMoves.append(contentsOf: effects)
            return
        }
        
        // wait until pendingMoves empty
        guard pendingMoves.isEmpty else {
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: state) }
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
        guard state.outcome == nil else {
            return
        }
        
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: state) }.flatMap { $0 }
        let database = self.database
        // ⚠️ Dispatch emit valid moves after loop completed
        DispatchQueue.main.async {
            database.setValidMoves(validMoves)
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

private extension GameLoop {
    var state: GameStateProtocol {
        guard let value = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        return value
    }
}
