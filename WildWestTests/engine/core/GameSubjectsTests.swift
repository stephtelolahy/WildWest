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
    
    private var stateSubject: BehaviorSubject<GameStateProtocol>!
    private var executedMoveSubject: PublishSubject<GameMove>!
    private var executedUpdateSubject: PublishSubject<GameUpdate>!
    private var validMovesSubject: BehaviorSubject<[GameMove]>!
    
    private var stateObservers: [TestableObserver<GameStateProtocol>]!
    private var executedMoveObservers: [TestableObserver<GameMove>]!
    private var validMovesObservers: [TestableObserver<[GameMove]>]!
    private var updateObservers: [TestableObserver<GameUpdate>]!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        DefaultValueRegistry.register(value: FigureName.jesseJones, forType: FigureName.self)
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1").role(is: .sheriff).withDefault()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2").role(is: .outlaw).withDefault()
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3").role(is: .renegade).withDefault()
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4").role(is: .deputy).withDefault()
        mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
            .withEnabledDefaultImplementation(GameStateProtocolStub())
        
        stateSubject = BehaviorSubject(value: mockState)
        executedMoveSubject = PublishSubject()
        executedUpdateSubject = PublishSubject()
        validMovesSubject = BehaviorSubject(value: [])
        
        sut = GameSubjects(stateSubject: stateSubject,
                           executedMoveSubject: executedMoveSubject,
                           executedUpdateSubject: executedUpdateSubject,
                           validMovesSubject: validMovesSubject)
        
        let scheduler = TestScheduler(initialClock: 0)
        
        stateObservers = Array(1...4).map { index in
            let observer = scheduler.createObserver(GameStateProtocol.self)
            sut.state(observedBy: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        executedMoveObservers = Array(1...4).map { _ in
            let observer = scheduler.createObserver(GameMove.self)
            sut.executedMove().subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        validMovesObservers = Array(1...4).map { index in
            let observer = scheduler.createObserver([GameMove].self)
            sut.validMoves(for: "p\(index)").subscribe(observer).disposed(by: disposeBag)
            return observer
        }
        
        updateObservers = Array(1...4).map { _ in
            let observer = scheduler.createObserver(GameUpdate.self)
            sut.executedUpdate().subscribe(observer).disposed(by: disposeBag)
            return observer
        }
    }
    
    func test_PlayersOrdersObservedBy() {
        // Given
        // When
        // Assert
        
        XCTAssertEqual(sut.playerIds(observedBy: nil), ["p1", "p2", "p3", "p4"])
        XCTAssertEqual(sut.playerIds(observedBy: "p1"), ["p1", "p2", "p3", "p4"])
        XCTAssertEqual(sut.playerIds(observedBy: "p2"), ["p2", "p3", "p4", "p1"])
        XCTAssertEqual(sut.playerIds(observedBy: "p3"), ["p3", "p4", "p1", "p2"])
        XCTAssertEqual(sut.playerIds(observedBy: "p4"), ["p4", "p1", "p2", "p3"])
    }
    
    func test_AllObserversReveiceInitialState() throws {
        // Given
        // When
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 1) }
        XCTAssertEqual(stateObservers[0].events.first?.value.event.element?.allPlayers.map { $0.identifier }, ["p1", "p2", "p3", "p4"])
        XCTAssertEqual(stateObservers[1].events.first?.value.event.element?.allPlayers.map { $0.identifier }, ["p2", "p3", "p4", "p1"])
        XCTAssertEqual(stateObservers[2].events.first?.value.event.element?.allPlayers.map { $0.identifier }, ["p3", "p4", "p1", "p2"])
        XCTAssertEqual(stateObservers[3].events.first?.value.event.element?.allPlayers.map { $0.identifier }, ["p4", "p1", "p2", "p3"])
    }
    
    func test_AllObserversReceiveEmitedState() {
        // Given
        // When
        stateSubject.onNext(mockState)
        
        // Assert
        stateObservers.forEach { XCTAssertEqual($0.events.count, 2) }
    }
    
    func test_AllObserversReceiveEmitedExecutedMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        executedMoveSubject.onNext(move)
        
        // Assert
        executedMoveObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
    
    func test_AllObserversReceiveEmitedValidMoves() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "p1")
        // When
        validMovesSubject.onNext([move])
        
        // Assert
        validMovesObservers.forEach { XCTAssertEqual($0.events.count, 2) }
    }
    
    func test_AllObserversReceiveEmitedUpdate() {
        // Given
        let update = GameUpdate.flipOverFirstDeckCard
        
        // When
        executedUpdateSubject.onNext(update)
        
        // Assert
        updateObservers.forEach { XCTAssertEqual($0.events.count, 1) }
    }
}
