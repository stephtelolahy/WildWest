//
//  GLoop.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/10/2020.
//

import RxSwift

public protocol GLoopProtocol {
    func run(_ move: GMove?) -> Completable
}

public class GLoop: GLoopProtocol {
    
    // MARK: Dependencies
    
    private let eventsQueue: GEventQueueProtocol
    private let database: DatabaseProtocol
    private let matcher: AbilityMatcherProtocol
    private let timer: GTimerProtocol
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    
    // MARK: Init
    
    public init(eventsQueue: GEventQueueProtocol,
                database: DatabaseProtocol,
                matcher: AbilityMatcherProtocol,
                timer: GTimerProtocol) {
        self.eventsQueue = eventsQueue
        self.database = database
        self.matcher = matcher
        self.timer = timer
    }
    
    // MARK: - GLoopProtocol
    
    public func run(_ move: GMove?) -> Completable {
        Completable.create { [self] completable in
            if let move = move {
                eventsQueue.queue(.run(move: move))
            }
            run(onCompleted: {
                completable(.completed)
                emitActiveMoves()
            }, onError: { error in
                completable(.error(error))
            })
            return Disposables.create()
        }
    }
}

private extension GLoop {
    
    func run(onCompleted: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        if let winner = database.currentState.winner {
            database.update(event: .gameover(winner: winner)).subscribe().disposed(by: disposeBag)
            onCompleted()
            return
        }
        
        guard let event = eventsQueue.pop() else {
            onCompleted()
            return
        }
        
        guard isApplicable(event) else {
            run(onCompleted: onCompleted, onError: onError)
            return
        }
        
        database.update(event: event).subscribe(onCompleted: { [weak self] in
            self?.queueEffects(on: event)
            self?.queueTriggers(on: event)
            self?.timer.wait(event) { 
                self?.run(onCompleted: onCompleted, onError: onError)
            }
        }, onError: onError)
        .disposed(by: disposeBag)
    }
    
    func isApplicable(_ event: GEvent) -> Bool {
        // <RULE> A move is applicable when it has effects>
        if case let .run(move) = event {
            return matcher.effects(on: move, in: database.currentState) != nil
        }
        // </RULE>
        return true
    }
    
    func queueEffects(on event: GEvent) {
        if case let .run(move) = event,
           let events = matcher.effects(on: move, in: database.currentState) {
            events.reversed().forEach {
                eventsQueue.push($0)
            }
        }
    }
    
    func queueTriggers(on event: GEvent) {
        if let moves = matcher.triggered(on: event, in: database.currentState) {
            moves.forEach {
                eventsQueue.queue(.run(move: $0))
            }
        }
    }
    
    func emitActiveMoves() {
        let state = database.currentState
        if state.winner == nil,
           let moves = matcher.active(in: state) {
            database.update(event: .activate(moves: moves)).subscribe().disposed(by: disposeBag)
        }
    }
}
