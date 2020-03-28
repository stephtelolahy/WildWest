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
    private let moveMatchers: [MoveMatcherProtocol]
    
    init(database: GameDatabaseProtocol,
         moveMatchers: [MoveMatcherProtocol],
         updateExecutor: UpdateExecutorProtocol,
         updateDelay: TimeInterval) {
        self.database = database
        self.stateSubject = BehaviorSubject(value: database.state)
        self.moveMatchers = moveMatchers
        self.updateExecutor = updateExecutor
        self.commandSubject = DelaySubject(delay: updateDelay)
    }
    
    func start() {
        sub(commandSubject.observable.subscribe(onNext: { [weak self] move in
            guard let self = self else {
                return
            }
            
            self.execute(move)
            self.stateSubject.onNext(self.database.state)
        }))
        
        moveMatchers.compactMap { $0.autoPlayMoves(matching: database.state) }
            .flatMap { $0 }
            .forEach { queue($0) }
    }
    
    func queue(_ move: GameMove) {
        commandSubject.onNext(move)
    }
    
    func observeAs(playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.hidingRoles(except: playerId) }
    }
}

extension GameEngine {
    
    func execute(_ move: GameMove) {
        // no move is allowed during update
        database.setValidMoves([:])
        
        // apply updates
        print("\n*** \(String(describing: move)) ***")
        
        let updatesQueue = moveMatchers.compactMap { $0.execute(move, in: database.state) }.flatMap { $0 }
        
        updatesQueue.forEach { update in
            print("> \(String(describing: update))")
            updateExecutor.execute(update, in: database)
        }
        
        database.addExecutedMove(move)
        
        // check if game over
        guard database.state.outcome == nil else {
            return
        }
        
        // check effects
        let effects = moveMatchers.compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            effects.forEach { commandSubject.onNext($0) }
            return
        }
        
        // check autoPlay moves
        let autoPlays = moveMatchers.compactMap { $0.autoPlayMoves(matching: database.state) }.flatMap { $0 }
        if !autoPlays.isEmpty {
            autoPlays.forEach { commandSubject.onNext($0) }
            return
        }
        
        // finally generate valid moves
        let validMoves = moveMatchers.compactMap { $0.validMoves(matching: database.state) }
            .flatMap { $0 }
            .groupedByActor()
        
        guard validMoves.keys.count <= 1 else {
            fatalError("Illegal multiple active players (\(validMoves.keys.count))")
        }
        
        database.setValidMoves(validMoves)
    }
}
