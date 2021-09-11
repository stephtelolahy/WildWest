//
//  GEngine.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 28/10/2020.
//

import RxSwift

public class GEngine: EngineProtocol {
    
    // MARK: - Dependencies
    
    private let database: DatabaseProtocol
    private let queue: GEventQueueProtocol
    private let rules: GameRulesProtocol
    private let timer: GTimerProtocol
    
    // MARK: - Private
    
    private var running: Bool = false
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    public init(queue: GEventQueueProtocol,
                database: DatabaseProtocol,
                rules: GameRulesProtocol,
                timer: GTimerProtocol) {
        self.queue = queue
        self.database = database
        self.rules = rules
        self.timer = timer
    }
    
    // MARK: - EngineProtocol
    
    public func execute(_ move: GMove?, completion: ((Error?) -> Void)?) {
        guard !running else {
            completion?(NSError(domain: "Engine busy", code: 0))
            return
        }
        running = true
        
        if let move = move {
            queue.queue(.run(move: move))
        }
        
        DispatchQueue.main.async { [weak self] in
                    self?.run(onCompleted: { [weak self] in
                        self?.running = false
                        self?.delayEmitActiveMoves()
                        completion?(nil)
                    }, onError: { error in
                        completion?(error)
                    })
        }
    }
}

private extension GEngine {
    
    func run(onCompleted: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        if database.currentState.winner != nil {
            onCompleted()
            return
        }
        
        if let winner = rules.winner(in: database.currentState) {
            database.update(event: .gameover(winner: winner)).subscribe(onCompleted: { [weak self] in
                self?.run(onCompleted: onCompleted, onError: onError)
            }).disposed(by: disposeBag)
            return
        }
        
        guard let event = queue.pop() else {
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
            return rules.effects(on: move, in: database.currentState) != nil
        }
        // </RULE>
        return true
    }
    
    func queueEffects(on event: GEvent) {
        if case let .run(move) = event,
           let events = rules.effects(on: move, in: database.currentState) {
            events.reversed().forEach {
                queue.push($0)
            }
        }
    }
    
    func queueTriggers(on event: GEvent) {
        if let moves = rules.triggered(on: event, in: database.currentState) {
            moves.forEach {
                queue.queue(.run(move: $0))
            }
        }
    }
    
    func delayEmitActiveMoves() {
        DispatchQueue.main.async { [weak self] in
            self?.emitActiveMoves()
        }
    }
    
    func emitActiveMoves() {
        let state = database.currentState
        if state.winner == nil,
           let moves = rules.active(in: state) {
            database.update(event: .activate(moves: moves)).subscribe().disposed(by: disposeBag)
        }
    }
}
