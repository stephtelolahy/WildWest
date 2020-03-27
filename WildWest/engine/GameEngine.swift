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
    private let commandSubject: DelaySubject<GameMove>
    
    private let database: GameDatabaseProtocol
    private let updateExecutor: UpdateExecutorProtocol
    
    private let validMoveMatchers: [ValidMoveMatcherProtocol]
    private let autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol]
    private let effectMatchers: [EffectMatcherProtocol]
    private let moveExecutors: [MoveExecutorProtocol]
    
    init(database: GameDatabaseProtocol,
         validMoveMatchers: [ValidMoveMatcherProtocol],
         autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol],
         effectMatchers: [EffectMatcherProtocol],
         moveExecutors: [MoveExecutorProtocol],
         updateExecutor: UpdateExecutorProtocol,
         updateDelay: TimeInterval) {
        self.database = database
        self.stateSubject = BehaviorSubject(value: database.state)
        self.validMoveMatchers = validMoveMatchers
        self.autoPlayMoveMatchers = autoPlayMoveMatchers
        self.effectMatchers = effectMatchers
        self.moveExecutors = moveExecutors
        self.updateExecutor = updateExecutor
        self.commandSubject = DelaySubject(delay: updateDelay)
    }
    
    func start() {
        sub(commandSubject.observable.subscribe(onNext: { [weak self] move in
            self?.execute(move)
        }))
        
        guard let sheriff = database.state.players.first(where: { $0.role == .sheriff }) else {
            return
        }
        
        database.setTurn(sheriff.identifier)
        queue(GameMove(name: .startTurn, actorId: sheriff.identifier))
    }
    
    func queue(_ move: GameMove) {
        commandSubject.onNext(move)
    }
    
    func execute(_ move: GameMove) {
        executeMove(move)
        stateSubject.onNext(database.state)
    }
    
    func observeAs(playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.hidingRoles(except: playerId) }
    }
}

private extension GameEngine {
    func executeMove(_ move: GameMove) {
        // no move is allowed during update
        database.setValidMoves([:])
        
        // apply updates
        executeUpdates(move)
        
        // check if game over
        guard database.state.outcome == nil else {
            return
        }
        
        // check effects
        let effects = effectMatchers
            .compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            effects.forEach { commandSubject.onNext($0) }
            return
        }
        
        // check autoPlay moves
        let autoPlays = autoPlayMoveMatchers
            .compactMap { $0.autoPlayMoves(matching: database.state) }
            .flatMap { $0 }
        if !autoPlays.isEmpty {
            autoPlays.forEach { commandSubject.onNext($0) }
            return
        }
        
        // finally generate valid moves
        let validMoves = validMoveMatchers
            .compactMap { $0.validMoves(matching: database.state) }
            .flatMap { $0 }
            .groupedByActor()
        
        guard validMoves.keys.count <= 1 else {
            fatalError("Illegal multiple active players (\(validMoves.keys.count))")
        }
        
        database.setValidMoves(validMoves)
    }
    
    func executeUpdates(_ move: GameMove) {
        let updatesQueue = moveExecutors
            .compactMap { $0.execute(move, in: database.state) }
            .flatMap { $0 }
        
        updatesQueue.forEach { update in
            print(String(describing: update))
            updateExecutor.execute(update, in: database)
        }
        
        database.addExecutedMove(move)
        print("\n*** \(String(describing: move)) ***")
    }
}
