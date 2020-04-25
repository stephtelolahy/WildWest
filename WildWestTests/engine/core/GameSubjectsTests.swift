//
//  GameSubjectsTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import Cuckoo

class GameSubjectsTests: XCTestCase {
    
    private var sut: GameSubjectsProtocol!
    private var mockState: MockGameStateProtocol!
    private var mockStateSubject: BehaviorSubject<GameStateProtocol>!
    
    private var stateObservers: [TestableObserver<GameStateProtocol>]!
    private var executedMoveObservers: [TestableObserver<GameMove>]!
    private var validMovesObservers: [TestableObserver<[GameMove]>]!
    private var updateObservers: [TestableObserver<GameUpdate>]!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        mockStateSubject = BehaviorSubject(value: mockState)
        
        sut = GameSubjects(stateSubject: mockStateSubject,
                           executedMoveSubject: PublishSubject(),
                           executedUpdateSubject: PublishSubject(),
                           validMovesSubject: PublishSubject())
        
        let scheduler = TestScheduler(initialClock: 0)
        
        stateObservers = Array(1...7).map { index in
            let observer = scheduler.createObserver(GameStateProtocol.self)
            sut.state(observedBy: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        executedMoveObservers = Array(1...7).map { _ in
            let observer = scheduler.createObserver(GameMove.self)
            sut.executedMove().subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        validMovesObservers = Array(1...7).map { index in
            let observer = scheduler.createObserver([GameMove].self)
            sut.validMoves(for: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        updateObservers = Array(1...7).map { _ in
            let observer = scheduler.createObserver(GameUpdate.self)
            sut.executedUpdate().subscribe(observer).disposed(by: disposeBag)
            return observer
        }
    }
    
    func test_AllObserversReveiceInitialState() throws {
        // Given
        // When
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedState() {
        // Given
        // When
        
        mockStateSubject.onNext(mockState)
        mockStateSubject.onNext(mockState)
        
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 3) }
    }
    
    func test_AllObserversReceiveEmitedExecutedMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        sut.emitExecutedMove(move)
        
        // Assert
        executedMoveObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedValidMoves() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        sut.emitValidMoves([move])
        
        // Assert
        validMovesObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedUpdate() {
        // Given
        let update = GameUpdate.flipOverFirstDeckCard
        
        // When
        sut.emitExecutedUpdate(update)
        
        // Assert
        updateObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
}
