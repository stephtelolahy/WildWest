//
//  GameLoop.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameLoop: GameLoopProtocol {
    
    // MARK: Dependencies
    
    private let database: GameDatabaseProtocol
    private let moveMatcher: MoveMatcherProtocol
    private let updateExecutor: UpdateExecutorProtocol
    
    private let executedMoveSubject: PublishSubject<GameMove>
    private let executedUpdateSubject: PublishSubject<GameUpdate>
    private let validMovesSubject: PublishSubject<[String: [GameMove]]>
    
    // MARK: Internal Properties
    
    private var running: Bool
    private var pendingMoves: [GameMove]
    private var pendingUpdates: [GameUpdate]
    
    // MARK: Init
    
    init(database: GameDatabaseProtocol,
         moveMatcher: MoveMatcherProtocol,
         updateExecutor: UpdateExecutorProtocol,
         executedMoveSubject: PublishSubject<GameMove>,
         executedUpdateSubject: PublishSubject<GameUpdate>,
         validMovesSubject: PublishSubject<[String: [GameMove]]>) {
        self.database = database
        self.moveMatcher = moveMatcher
        self.updateExecutor = updateExecutor
        self.executedMoveSubject = executedMoveSubject
        self.executedUpdateSubject = executedUpdateSubject
        self.validMovesSubject = validMovesSubject
        running = false
        pendingMoves = []
        pendingUpdates = []
    }
    
    // MARK: GameLoopProtocol
    
    func start(move: GameMove, completed: @escaping () -> Void) {
        
    }
}
