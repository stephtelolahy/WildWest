//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol, Subscribable {
    
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let executedMoveSubject: PublishSubject<GameMove>
    private let validMovesSubject: PublishSubject<[String: [GameMove]]>
    
    private let commandSubject: DelaySubject<GameMove>
    private let database: GameDatabaseProtocol
    private let updateExecutor: UpdateExecutorProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    
    init(database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         updateDelay: TimeInterval) {
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        stateSubject = BehaviorSubject(value: database.state)
        executedMoveSubject = PublishSubject()
        validMovesSubject = PublishSubject()
        commandSubject = DelaySubject(delay: updateDelay)
    }
    
    var allPlayersCount: Int {
        database.state.players.count
    }
    
    var executedMove: Observable<GameMove> {
        executedMoveSubject
    }
    
    func start() {
        observeCommandQueue()
        moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }.forEach { queue($0) }
    }
    
    func queue(_ move: GameMove) {
        commandSubject.onNext(move)
    }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.observed(by: playerId) }
    }
    
    func validMoves(for playerId: String?) -> Observable<[GameMove]> {
        validMovesSubject.map { $0[playerId ?? ""] ?? [] }
    }
}

extension GameEngine {
    
    func execute(_ move: GameMove) {
        
        print("\n*** \(String(describing: move)) ***")
        let matchers = moveMatchers.filter({ $0.execute(move, in: database.state) != nil })
        guard matchers.count == 1,
            let executor = matchers.first,
            let updatesQueue = executor.execute(move, in: database.state) else {
                fatalError("Illegal move executors (\(matchers.count)")
        }
        
        updatesQueue.forEach { update in
            print("> \(String(describing: update))")
            updateExecutor.execute(update, in: database)
        }
        
        // check game over
        if let outcome = database.state.claculateOutcome() {
            database.setOutcome(outcome)
            return
        }
        
        // queue effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            effects.forEach { commandSubject.onNext($0) }
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        if !autoPlays.isEmpty {
            autoPlays.forEach { commandSubject.onNext($0) }
            return
        }
    }
}

private extension GameEngine {
    
    func observeCommandQueue() {
        sub(commandSubject.observable.subscribe(onNext: { [weak self] move in
            self?.handleMove(move)
        }))
    }
    
    func handleMove(_ move: GameMove) {
        execute(move)
        
        emitState()
        
        emitExecutedMove(move)
        
        guard commandSubject.queue.isEmpty,
            database.state.outcome == nil else {
                emmitEmptyMoves()
                return
        }
        
        emitValidMoves()
    }
    
    func emitExecutedMove(_ move: GameMove) {
        executedMoveSubject.onNext(move)
    }
    
    func emitValidMoves() {
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: database.state) }
            .flatMap { $0 }
            .groupedByActor()
        
        guard validMoves.keys.count <= 1 else {
            fatalError("Illegal active players (\(validMoves.keys.count))")
        }
        
        validMovesSubject.onNext(validMoves)
    }
    
    func emmitEmptyMoves() {
        validMovesSubject.onNext([:])
    }
    
    func emitState() {
        stateSubject.onNext(database.state)
    }
}
