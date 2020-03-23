//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    private let database: GameDatabaseProtocol
    private let validMoveMatchers: [ValidMoveMatcherProtocol]
    private let autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol]
    private let effectMatchers: [EffectMatcherProtocol]
    private let moveExecutors: [MoveExecutorProtocol]
    private let updateExecutors: [UpdateExecutorProtocol]
    private let updateDelay: Double
    
    private var movesQueue: [GameMove] = []
    private var running = false
    
    init(database: GameDatabaseProtocol,
         validMoveMatchers: [ValidMoveMatcherProtocol],
         autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol],
         effectMatchers: [EffectMatcherProtocol],
         moveExecutors: [MoveExecutorProtocol],
         updateExecutors: [UpdateExecutorProtocol],
         updateDelay: Double) {
        self.database = database
        self.stateSubject = BehaviorSubject(value: database.state)
        self.validMoveMatchers = validMoveMatchers
        self.autoPlayMoveMatchers = autoPlayMoveMatchers
        self.effectMatchers = effectMatchers
        self.moveExecutors = moveExecutors
        self.updateExecutors = updateExecutors
        self.updateDelay = updateDelay
    }
    
    func start() {
        guard let sheriff = database.state.players.first(where: { $0.role == .sheriff }) else {
            return
        }
        
        database.setTurn(sheriff.identifier)
        queue(GameMove(name: .startTurn, actorId: sheriff.identifier))
    }
    
    func queue(_ move: GameMove) {
        movesQueue.append(move)
        
        guard !running else {
            return
        }
        
        running = true
        
        let move = self.movesQueue.remove(at: 0)
        self.execute(move)
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: updateDelay, repeats: true) { [weak self] timer in
                guard let self = self else {
                    return
                }
                
                guard !self.movesQueue.isEmpty else {
                    timer.invalidate()
                    self.running = false
                    return
                }
                
                let move = self.movesQueue.remove(at: 0)
                self.execute(move)
            }
        } else {
            // TODO: Fallback on earlier versions
        }
    }
    
    func execute(_ move: GameMove) {
        _execute(move)
        stateSubject.onNext(database.state)
    }
    
    private func _execute(_ move: GameMove) {
        // no move is allowed during update
        database.setValidMoves([:])
        
        database.addExecutedMove(move)
        print("\n*** \(String(describing: move)) ***")
        
        let updatesQueue = moveExecutors
            .compactMap { $0.execute(move, in: database.state) }
            .flatMap { $0 }
        
        updatesQueue.forEach { update in
            print(String(describing: update))
            updateExecutors.forEach { executor in
                executor.execute(update, in: database)
            }
        }
        
        // check if game over
        guard database.state.outcome == nil else {
            return
        }
        
        // check effects
        let effects = effectMatchers
            .compactMap { $0.effect(onExecuting: move, in: database.state) }
        if !effects.isEmpty {
            movesQueue.append(contentsOf: effects)
            return
        }
        
        // check autoPlay moves
        let autoPlays = autoPlayMoveMatchers
            .compactMap { $0.autoPlayMoves(matching: database.state) }
            .flatMap { $0 }
        if !autoPlays.isEmpty {
            movesQueue.append(contentsOf: autoPlays)
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
}
