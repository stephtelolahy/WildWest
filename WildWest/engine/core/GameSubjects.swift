//
//  GameSubjects.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameSubjects: GameSubjectsProtocol {
    
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let executedMoveSubject: PublishSubject<GameMove>
    private let executedUpdateSubject: PublishSubject<GameUpdate>
    private let validMovesSubject: PublishSubject<[GameMove]>
    
    init(stateSubject: BehaviorSubject<GameStateProtocol>,
         executedMoveSubject: PublishSubject<GameMove>,
         executedUpdateSubject: PublishSubject<GameUpdate>,
         validMovesSubject: PublishSubject<[GameMove]>) {
        self.stateSubject = stateSubject
        self.executedMoveSubject = executedMoveSubject
        self.executedUpdateSubject = executedUpdateSubject
        self.validMovesSubject = validMovesSubject
    }
    
    var sheriffId: String {
        guard let state = try? stateSubject.value(),
            let sheriff = state.players.first(where: { $0.role == .sheriff }) else {
                fatalError("Illegal state")
        }
        
        return sheriff.identifier
    }
    
    var playerIds: [String] {
        guard let state = try? stateSubject.value() else {
            fatalError("Illegal state")
        }
        
        return state.players.map { $0.identifier }
    }
    
    func state(observedBy playerId: String?) -> Observable<GameStateProtocol> {
        stateSubject.map { $0.observed(by: playerId) }
    }
    
    func executedMove() -> Observable<GameMove> {
        executedMoveSubject
    }
    
    func executedUpdate() -> Observable<GameUpdate> {
        executedUpdateSubject
    }
    
    func validMoves(for playerId: String) -> Observable<[GameMove]> {
        validMovesSubject.map { $0.filter({ $0.actorId == playerId }) }
    }
    
    func emitExecutedUpdate(_ update: GameUpdate) {
        executedUpdateSubject.onNext(update)
    }
    
    func emitExecutedMove(_ move: GameMove) {
        executedMoveSubject.onNext(move)
    }
    
    func emitValidMoves(_ moves: [GameMove]) {
        validMovesSubject.onNext(moves)
    }
}
