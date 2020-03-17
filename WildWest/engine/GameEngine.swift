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
    
    init(database: GameDatabaseProtocol,
         validMoveMatchers: [ValidMoveMatcherProtocol],
         autoPlayMoveMatchers: [AutoplayMoveMatcherProtocol],
         effectMatchers: [EffectMatcherProtocol],
         moveExecutors: [MoveExecutorProtocol],
         updateExecutors: [UpdateExecutorProtocol]) {
        self.database = database
        self.stateSubject = BehaviorSubject(value: database.state)
        self.validMoveMatchers = validMoveMatchers
        self.autoPlayMoveMatchers = autoPlayMoveMatchers
        self.effectMatchers = effectMatchers
        self.moveExecutors = moveExecutors
        self.updateExecutors = updateExecutors
    }
    
    func start() {
        guard let sheriff = database.state.players.first(where: { $0.role == .sheriff }) else {
            return
        }
        
        database.setTurn(sheriff.identifier)
        execute(GameMove(name: .startTurn, actorId: sheriff.identifier))
    }
    
    // swiftlint:disable function_body_length
    func execute(_ command: GameMove) {
        // no move is allowed during update
        database.setValidMoves([:])
        
        var movesQueue: [GameMove] = [command]
        while !movesQueue.isEmpty {
            // wait some delay
            do {
                sleep(1)
            }
            
            let move = movesQueue.remove(at: 0)
            
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
                break
            }
            
            // check effects
            let effects = effectMatchers
                .compactMap { $0.effects(onExecuting: move, in: database.state) }
            if !effects.isEmpty {
                movesQueue.append(contentsOf: effects)
                continue
            }
            
            // check autoPlay moves
            let autoPlays = autoPlayMoveMatchers
                .compactMap { $0.autoPlayMoves(matching: database.state) }
                .flatMap { $0 }
            if !autoPlays.isEmpty {
                movesQueue.append(contentsOf: autoPlays)
                continue
            }
            
            // finally generate valid moves
            let validMoves: [String: [GameMove]] = validMoveMatchers
                .compactMap { $0.validMoves(matching: database.state) }
                .merged()
            guard validMoves.keys.count <= 1 else {
                fatalError("Illegal multiple active players (\(validMoves.keys.count))")
            }
            
            database.setValidMoves(validMoves)
        }
        
        stateSubject.onNext(database.state)
    }
}
