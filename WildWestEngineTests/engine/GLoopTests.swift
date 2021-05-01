//
//  GLoopTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 30/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo
import RxSwift

class GLoopTests: XCTestCase {
    
    private var sut: GLoopProtocol!
    private var mockQueue: MockGEventQueueProtocol!
    private var mockDatabase: MockDatabaseProtocol!
    private var mockMatcher: MockAbilityMatcherProtocol!
    private var mockTimer: MockGTimerProtocol!
    private var mockState: MockStateProtocol!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        mockQueue = MockGEventQueueProtocol().withEnabledDefaultImplementation(GEventQueueProtocolStub())
        mockState = MockStateProtocol().withDefault()
        mockDatabase = MockDatabaseProtocol().withEnabledDefaultImplementation(DatabaseProtocolStub())
        mockMatcher = MockAbilityMatcherProtocol().withEnabledDefaultImplementation(AbilityMatcherProtocolStub())
        mockTimer = MockGTimerProtocol().withEnabledDefaultImplementation(GTimerProtocolStub())
        sut = GLoop(eventsQueue: mockQueue, 
                    database: mockDatabase,
                    matcher: mockMatcher,
                    timer: mockTimer)
        
        stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(BehaviorSubject(value: mockState))
            when(mock.update(event: any())).thenReturn(Completable.empty())
        }
    }
    
    func test_EmitActiveMoves_IfLoopCompleted() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        stub(mockMatcher) { mock in
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
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_DoNotEmitActiveMoves_IfCompletedOnGameOver() {
        // Given
        let move1 = GMove("m1", actor: "p1")
        stub(mockMatcher) { mock in
            when(mock.active(in: state(equalTo: mockState))).thenReturn([move1])
        }
        stub(mockState) { mock in
            when(mock.winner.get).thenReturn(.sheriff)
        }
        
        // When
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
        // Assert
        verifyNoMoreInteractions(mockMatcher)
        verify(mockDatabase, never()).update(event: equal(to: .activate(moves: [move1])))
    }
    
    func test_QueueMove_IfExecuting() {
        // Given
        let move = GMove("m1", actor: "p1")
        
        // When
        sut.run(move).subscribe().disposed(by: disposeBag)
        
        // Assert
        verify(mockQueue).queue(equal(to: .run(move: move)))
    }
    
    func test_DoNotQueueMove_IfExecutingWithoutMove() {
        // Given
        // When
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
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
        sut.run(nil).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        // assert
        verify(mockQueue, never()).pop()
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_EmitWinner_IfGameOver() {
        // Given
        stub(mockState) { mock in
            when(mock.winner.get).thenReturn(.outlaw)
        }
        let expectation = XCTestExpectation(description: "emit game over")
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: .gameover(winner: .outlaw)))).then { _ in
                expectation.fulfill()
                return Completable.empty()
            }
        }
        
        // When
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
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
        sut.run(nil).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        // Assert
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_ApplyEvent_IfRunning() {
        // Given
        let event: GEvent = .revealDeck 
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        
        // When
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
        // Assert
        verify(mockDatabase).update(event: equal(to: event))
    }
    
    func test_ThrowsError_IfFailedApplyingEvent() {
        // Given
        let event: GEvent = .setStoreView(player: "p1") 
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event)
        }
        stub(mockDatabase) { mock in
            when(mock.update(event: equal(to: event))).thenReturn(Completable.error(NSError(domain: "An error occurred", code: 0)))
        }
        let expectation = XCTestExpectation(description: "error occurred")
        
        // When
        sut.run(nil).subscribe(onError: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
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
        sut.run(nil).subscribe(onCompleted: {
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        // Assert
        verify(mockQueue, times(3)).pop()
        verify(mockDatabase).update(event: equal(to: event1))
        verify(mockTimer).wait(equal(to: event1), completion: any())
        verify(mockDatabase).update(event: equal(to: event2))
        verify(mockTimer).wait(equal(to: event2), completion: any())
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_DoNotApplyMove_IfHasNoEffects() {
        // Given
        let move = GMove("m1", actor: "p1")
        let event: GEvent = .run(move: move)
        stub(mockQueue) { mock in
            when(mock.pop()).thenReturn(event, nil)
        }
        stub(mockMatcher) { mock in
            when(mock.effects(on: equal(to: move), in: state(equalTo: mockState))).thenReturn(nil)
        }
        
        // When
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
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
        stub(mockMatcher) { mock in
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
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
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
        stub(mockMatcher) { mock in
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
        sut.run(nil).subscribe().disposed(by: disposeBag)
        
        // Assert
        wait(for: [move1Expectation, move2Expectation], timeout: 0.1, enforceOrder: true)
    }
}
