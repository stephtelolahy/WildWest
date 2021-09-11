//
//  EngineTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 28/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Cuckoo
import RxSwift

class EngineTests: XCTestCase {
    
    private var sut: EngineProtocol!
    private var mockQueue: MockGEventQueueProtocol!
    private var mockDatabase: MockDatabaseProtocol!
    private var mockRules: MockGameRulesProtocol!
    private var mockTimer: MockGTimerProtocol!
    private var mockState: MockStateProtocol!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        mockQueue = MockGEventQueueProtocol().withEnabledDefaultImplementation(GEventQueueProtocolStub())
        mockState = MockStateProtocol().withDefault()
        mockDatabase = MockDatabaseProtocol().withEnabledDefaultImplementation(DatabaseProtocolStub())
        mockRules = MockGameRulesProtocol().withEnabledDefaultImplementation(GameRulesProtocolStub())
        mockTimer = MockGTimerProtocol().withEnabledDefaultImplementation(GTimerProtocolStub())
        sut = GEngine(queue: mockQueue,
                      database: mockDatabase,
                      rules: mockRules,
                      timer: mockTimer)
        
        stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(BehaviorSubject(value: mockState))
            when(mock.update(event: any())).thenReturn(Completable.empty())
        }
    }
    
    func test_DoNothing_IfAlreadyExecuting() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p1")
        let move3 = GMove("m3", actor: "p1")
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(.emptyQueue)
        }
        stub(mockDatabase) { mock in
            when(mock.update(event: any())).then { _ in
                Completable.empty().delay(.milliseconds(1), scheduler: MainScheduler.instance)
            }
        }
        
        // When
        sut.execute(move1) { error in
            XCTAssertNil(error)
        }
        sut.execute(move2) { error in
            XCTAssertNotNil(error)
        }
        sut.execute(move3) { error in
            XCTAssertNotNil(error)
        }
        
        // Assert
        verify(mockQueue).queue(equal(to: .run(move: move1)))
        verify(mockQueue, never()).queue(equal(to: .run(move: move2)))
        verify(mockQueue, never()).queue(equal(to: .run(move: move3)))
    }
    
    func test_EmitActiveMoves_IfLoopCompleted() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        stub(mockRules) { mock in
            when(mock.active(in: state(equalTo: mockState))).thenReturn([move1])
        }
        let expectation = XCTestExpectation(description: "Emited active moves")
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: .activate(moves: [move1])))).then({ _ in
                expectation.fulfill()
                return Completable.empty()
            })
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_DoNotEmitActiveMoves_IfCompletedOnGameOver() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        stub(mockRules) { mock in
            when(mock.active(in: state(equalTo: mockState))).thenReturn([move1])
        }
        stub(mockState) { mock in
            when(mock.winner.get).thenReturn(.sheriff)
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        verifyNoMoreInteractions(mockRules)
        verify(mockDatabase, never()).update(event: equal(to: .activate(moves: [move1])))
    }
    
    func test_QueueRunEvent_IfExecutingMove() {
        // Given
        let move = GMove("m1", actor: "p1")
        
        // When
        sut.execute( move, completion: nil)
        
        // Assert
        verify(mockQueue).queue(equal(to: .run(move: move)))
    }
    
    func test_DoNotQueueMove_IfExecutingWithoutMove() {
        // Given
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        verify(mockQueue, never()).queue(any())
    }
    
    func test_Complete_IfGameOver() {
        // Given
        stub(mockState) { mock in
            when(mock.winner.get).thenReturn(.outlaw)
        }
        let expectation = XCTestExpectation(description: "completed")
        
        // When
        sut.execute(nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        // assert
        verify(mockQueue, never()).pop()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_EmitWinner_IfGameIsOver() {
        // Given
        stub(mockRules) { mock in
            when(mock.winner(in: state(equalTo: mockState))).thenReturn(.outlaw)
        }
        let expectation = XCTestExpectation(description: "emit game over")
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: .gameover(winner: .outlaw)))).then { _ in
                expectation.fulfill()
                return Completable.never()
            }
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_Complete_IfNoEvents() {
        // Given
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(nil)
        }
        let expectation = XCTestExpectation(description: "completed")
        
        // When
        sut.execute(nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_ApplyEvent_IfRunning() {
        // Given
        let event: GEvent = .flipDeck
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        let expectation = XCTestExpectation(description: "completed")
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: event))).then { _ in
                expectation.fulfill()
                return Completable.empty()
            }
        }
        
        // When
        sut.execute(nil, completion: nil)
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_ThrowsError_IfFailedApplyingEvent() {
        // Given
        let event: GEvent = .emptyQueue
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: event))).thenReturn(Completable.error(NSError(domain: "An error occurred", code: 0)))
        }
        let expectation = XCTestExpectation(description: "error occurred")
        
        // When
        sut.execute(nil) { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_Complete_IfAllEventsApplied() {
        // Given
        let expectation = XCTestExpectation(description: "completed")
        let event1: GEvent = .drawDeck(player: "p1")
        let event2: GEvent = .setPhase(value: 2)
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event1, event2, nil)
        }
        stub(mockTimer) { mock in
            when(mock.wait(any(), completion: any())).then { _, completion in
                completion()
            }
        }
        
        // When
        sut.execute( nil) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 0.5)
        verify(mockQueue, times(3)).pop()
        verify(mockDatabase).update(event: equal(to: event1))
        verify(mockTimer).wait(equal(to: event1), completion: any())
        verify(mockDatabase).update(event: equal(to: event2))
        verify(mockTimer).wait(equal(to: event2), completion: any())
    }
    
    func test_DoNotApplyMove_IfHasNoEffects() {
        // Given
        let move = GMove("m1", actor: "p1")
        let event: GEvent = .run(move: move)
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event, nil)
        }
        stub(mockRules) { mock in
            when(mock.effects(on: equal(to: move), in: state(equalTo: mockState))).thenReturn(nil)
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        verify(mockDatabase, never()).update(event: equal(to: event))
    }
    
    func test_PushEffects_IfApplyingMove() {
        // Given
        let move = GMove("m1", actor: "p1")
        let event: GEvent = .run(move: move)
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        let effect1: GEvent = .drawDeck(player: "p1")
        let effect2: GEvent = .drawDeck(player: "p2")
        stub(mockRules) { mock in
            when(mock.effects(on: equal(to: move), in: state(equalTo: mockState)))
                .thenReturn([effect1, effect2])
        }
        
        let effect1Expectation = XCTestExpectation(description: "pushing effect1")
        let effect2Expectation = XCTestExpectation(description: "pushing effect2")
        stub(mockQueue) { mock in
            mock.push(equal(to: effect1)).then { _ in effect1Expectation.fulfill() }
            mock.push(equal(to: effect2)).then { _ in effect2Expectation.fulfill() }
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        wait(for: [effect2Expectation, effect1Expectation], timeout: 0.1, enforceOrder: true)
    }
    
    func test_QueueTriggeredMoves_IfApplyingEvent() {
        // Given
        let event: GEvent = .looseHealth(player: "p1", offender: "p2")
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        stub(mockState) { mock in
            when(mock.playOrder.get).thenReturn(["p1"])
        }
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p2")
        stub(mockRules) { mock in
            when(mock.triggered(on: equal(to: event), in: state(equalTo: mockState)))
                .thenReturn([move1, move2])
        }
        let move1Expectation = XCTestExpectation(description: "queueing move1")
        let move2Expectation = XCTestExpectation(description: "queueing move2")
        stub(mockQueue) { mock in
            mock.queue(equal(to: .run(move: move1))).then { _ in move1Expectation.fulfill() }
            mock.queue(equal(to: .run(move: move2))).then { _ in move2Expectation.fulfill() }
        }
        
        // When
        sut.execute( nil, completion: nil)
        
        // Assert
        wait(for: [move1Expectation, move2Expectation], timeout: 0.1, enforceOrder: true)
    }
}
