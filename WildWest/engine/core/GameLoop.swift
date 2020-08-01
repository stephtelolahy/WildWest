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
    private let moveMatchers: [MoveMatcherProtocol]
    private var completion: (() -> Void)?
    private var pendingMoves: [GameMove]
    private var pendingUpdates: [GameUpdate]
    private var currentMove: GameMove?
    
    init(delay: TimeInterval,
         database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         move: GameMove,
         completion: @escaping (() -> Void)) {
        self.delay = delay
        self.database = database
        self.moveMatchers = moveMatchers
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
        
        let state = database.state
        let updates = moveMatchers.compactMap({ $0.updates(onExecuting: move, in: state) }).flatMap { $0 }
        pendingUpdates.append(contentsOf: updates)
        
        sub(database.setExecutedMove(move)
            .andThen(database.setValidMoves([]))
            .subscribe(onCompleted: { [weak self] in
                self?.processUpdate()
            }, onError: { error in
                fatalError(error.localizedDescription)
            }))
    }
    
    func processUpdate() {
        guard !pendingUpdates.isEmpty else {
            postExecuteMove()
            return
        }
        
        let update = pendingUpdates.remove(at: 0)
        
        sub(database.setExecutedUpdate(update)
            .andThen(database.execute(update))
            .subscribe(onCompleted: { [weak self] in
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
        let state = database.state
        
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
        let autoPlays = moveMatchers.compactMap { $0.autoPlay(matching: state) }
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
        let state = database.state
        guard state.outcome == nil else {
            return
        }
        
        let validMoves = moveMatchers.compactMap { $0.moves(matching: state) }.flatMap { $0 }
        let database = self.database
        // ⚠️ Dispatch emit valid moves after loop completed
        DispatchQueue.main.async {
            _ = database.setValidMoves(validMoves).subscribe()
        }
    }
    
    func schedule(after waitDelay: TimeInterval, block: @escaping (() -> Void)) {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: waitDelay, repeats: false) { timer in
                timer.invalidate()
                block()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + waitDelay) {
                block()
            }
        }
    }
}
