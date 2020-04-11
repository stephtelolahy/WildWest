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
    
    private let database: GameDatabaseProtocol
    private let updateExecutor: UpdateExecutorProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    private let commandQueue: CommandQueueProtocol
    
    init(database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         commandQueue: CommandQueueProtocol) {
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.commandQueue = commandQueue
        stateSubject = BehaviorSubject(value: database.state)
        executedMoveSubject = PublishSubject()
        validMovesSubject = PublishSubject()
    }
    
    var allPlayersCount: Int {
        database.state.players.count
    }
    
    func start() {
        observeCommandQueue()
        moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }.forEach { queue($0) }
    }
    
    func queue(_ move: GameMove) {
        commandQueue.add(move)
    }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.observed(by: playerId) }
    }
    
    func executedMove() -> Observable<GameMove> {
        executedMoveSubject
    }
    
    func validMoves(for playerId: String?) -> Observable<[GameMove]> {
        validMovesSubject.map { $0[playerId ?? ""] ?? [] }
    }
}

extension GameEngine: InternalGameEngineProtocol {
    
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
            effects.forEach { commandQueue.add($0) }
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        if !autoPlays.isEmpty {
            autoPlays.forEach { commandQueue.add($0) }
            return
        }
    }
    
    func emitState(_ state: GameStateProtocol) {
        stateSubject.onNext(state)
    }
    
    func emitExecutedMove(_ move: GameMove) {
        executedMoveSubject.onNext(move)
    }
    
    func emitValidMoves(_ moves: [String: [GameMove]]) {
        validMovesSubject.onNext(moves)
    }
}

private extension GameEngine {
    
    func observeCommandQueue() {
        sub(commandQueue.pull().subscribe(onNext: { [weak self] move in
            self?.processCommand(move)
        }))
    }
    
    func processCommand(_ move: GameMove) {
        execute(move)
        emitState(database.state)
        emitExecutedMove(move)
        emitValidMoves(validMoves())
    }
    
    func validMoves() -> [String: [GameMove]] {
        guard commandQueue.isEmpty,
            database.state.outcome == nil else {
                return [:]
        }
        
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: database.state) }
            .flatMap { $0 }
            .groupedByActor()
        
        guard validMoves.keys.count <= 1 else {
            fatalError("Illegal active players (\(validMoves.keys.count))")
        }
        
        return validMoves
    }
}
