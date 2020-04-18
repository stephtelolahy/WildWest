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
    private let updatesSubject: PublishSubject<GameUpdate>
    private let executedMoveSubject: PublishSubject<GameMove>
    private let validMovesSubject: PublishSubject<[String: [GameMove]]>
    
    private let database: GameDatabaseProtocol
    private let updateExecutor: UpdateExecutorProtocol
    private let moveMatchers: [MoveMatcherProtocol]
    private let eventQueue: EventQueueProtocol
    
    init(database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         eventQueue: EventQueueProtocol) {
        self.database = database
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.eventQueue = eventQueue
        stateSubject = BehaviorSubject(value: database.state)
        executedMoveSubject = PublishSubject()
        updatesSubject = PublishSubject()
        validMovesSubject = PublishSubject()
    }
    
    var allPlayers: [PlayerProtocol] {
        database.state.players
    }
    
    func start() {
        observeEventQueue()
        moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }.forEach { execute($0) }
    }
    
    func execute(_ move: GameMove) {
        eventQueue.add(GameEvent(move: move))
    }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.observed(by: playerId) }
    }
    
    func executedMove() -> Observable<GameMove> {
        executedMoveSubject
    }
    
    func executedUpdates() -> Observable<GameUpdate> {
        updatesSubject
    }
    
    func validMoves(for playerId: String) -> Observable<[GameMove]> {
        validMovesSubject.map { $0[playerId] ?? [] }
    }
}

extension GameEngine: InternalGameEngineProtocol {
    
    func emitState(_ state: GameStateProtocol) {
        stateSubject.onNext(state)
    }
    
    func emitUpdate(_ update: GameUpdate) {
        updatesSubject.onNext(update)
    }
    
    func emitExecutedMove(_ move: GameMove) {
        executedMoveSubject.onNext(move)
    }
    
    func emitValidMoves(_ moves: [String: [GameMove]]) {
        validMovesSubject.onNext(moves)
    }
}

private extension GameEngine {
    
    func observeEventQueue() {
        sub(eventQueue.pop().subscribe(onNext: { [weak self] event in
            self?.processEvent(event)
        }))
    }
    
    func processEvent(_ event: GameEvent) {
        if let remainingUdates = event.updateGroups {
            process(event.move, updateGroups: remainingUdates)
        } else {
            preExecute(event.move)
            let updates = moveMatchers.updates(onExecuting: event.move, in: database.state)
            let updateGroups = updates.splitAnimatables()
            process(event.move, updateGroups: updateGroups)
        }
    }
    
    func process(_ move: GameMove, updateGroups: [[GameUpdate]]) {
        guard !updateGroups.isEmpty else {
            postExecute(move)
            return
        }
        
        let actualUpdates = updateGroups[0]
        actualUpdates.forEach { execute($0) }
        
        let remainingUdates = Array(updateGroups[1..<updateGroups.count])
        
        guard !remainingUdates.isEmpty else {
            postExecute(move)
            return
        }
        
        eventQueue.push(GameEvent(move: move, updateGroups: remainingUdates))
    }
    
    func preExecute(_ move: GameMove) {
        print("\n*** \(String(describing: move)) ***")
        
        emitExecutedMove(move)
        
        emitValidMoves([:])
    }
    
    func execute(_ update: GameUpdate) {
        print("> \(String(describing: update))")
        
        emitUpdate(update)
        
        updateExecutor.execute(update, in: database)
        
        emitState(database.state)
    }
    
    func postExecute(_ move: GameMove) {
        // emit game over
        if let outcome = database.state.claculateOutcome() {
            database.setOutcome(outcome)
            emitState(database.state)
            return
        }
        
        // queue effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            effects.forEach { eventQueue.add(GameEvent(move: $0)) }
            return
        }
        
        // wait until all queued moves executed
        guard eventQueue.isEmpty else {
            return
        }
        
        // queue autoPlay
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMove(matching: database.state) }
        if !autoPlays.isEmpty {
            autoPlays.forEach { eventQueue.add(GameEvent(move: $0)) }
            return
        }
        
        // wait until all queued moves executed
        guard eventQueue.isEmpty else {
            return
        }
        
        // emit valid moves
        let validMoves = moveMatchers.validMoves(matching: database.state)
        emitValidMoves(validMoves)
    }
}

private extension Array where Element == MoveMatcherProtocol {
    
    func validMoves(matching state: GameStateProtocol) -> [String: [GameMove]] {
        let moves = self.compactMap { $0.validMoves(matching: state) }
            .flatMap { $0 }
            .groupedByActor()
        
        guard moves.keys.count <= 1 else {
            fatalError("Illegal active players (\(moves.keys.count))")
        }
        
        return moves
    }
    
    func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate] {
        let matchers = self.filter({ $0.execute(move, in: state) != nil })
        guard matchers.count == 1,
            let executor = matchers.first,
            let updates = executor.execute(move, in: state) else {
                fatalError("Illegal move executors (\(matchers.count)")
        }
        
        return updates
    }
}
