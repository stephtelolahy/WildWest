//
//  DelayedEventQueueTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 15/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class DelayedEventQueueTests: XCTestCase {
    
    private let sut = DelayedEventQueue(delay: 0.5)
    private let disposeBag = DisposeBag()
    
    func test_EmitSingleAddedMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "px")
        let event = GameEvent(move: move)
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(GameEvent.self)
        sut.pop().subscribe(observer).disposed(by: disposeBag)
        
        // When
        sut.add(event)
        
        // Assert
        XCTAssertRecordedElements(observer.events, [event])
        XCTAssertEqual(sut.isEmpty, true)
    }
    
    func test_EmitMultipleAddedMoves() {
        // Given
        let move1 = GameEvent(move: GameMove(name: MoveName("m1"), actorId: "px"))
        let move2 = GameEvent(move: GameMove(name: MoveName("m2"), actorId: "px"))
        let move3 = GameEvent(move: GameMove(name: MoveName("m3"), actorId: "px"))
        
        let expectation = XCTestExpectation(description: "Emit all moves")
        var emitedMoves: [GameEvent] = []
        sut.pop().subscribe(onNext: { move in
            emitedMoves.append(move)
            if emitedMoves.count == 3 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        // When
        sut.add(move1)
        sut.add(move2)
        sut.add(move3)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(emitedMoves, [move1, move2, move3])
        XCTAssertEqual(sut.isEmpty, true)
    }
    
    func test_EmitToMultipleObservers() {
        // Given
        let move = GameEvent(move: GameMove(name: MoveName("m1"), actorId: "px"))
        
        let scheduler = TestScheduler(initialClock: 0)
        let observer1 = scheduler.createObserver(GameEvent.self)
        let observer2 = scheduler.createObserver(GameEvent.self)
        sut.pop().subscribe(observer1).disposed(by: disposeBag)
        sut.pop().subscribe(observer2).disposed(by: disposeBag)
        
        // When
        sut.add(move)
        
        // Assert
        XCTAssertRecordedElements(observer1.events, [move])
        XCTAssertRecordedElements(observer2.events, [move])
        XCTAssertEqual(sut.isEmpty, true)
    }
}
