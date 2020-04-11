//
//  DelayedCommandQueueTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 11/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class DelayedCommandQueueTests: XCTestCase {
    
    private let sut = DelayedCommandQueue(delay: 0.5)
    private let disposeBag = DisposeBag()
    
    func test_EmmitSingleAddedMove() {
        // Given
        let move = GameMove(name: MoveName("m1"), actorId: "px")
        
        let scheduler = TestScheduler(initialClock: 0)
        let commandObserver = scheduler.createObserver(GameMove.self)
        sut.pull().subscribe(commandObserver).disposed(by: disposeBag)
        
        // When
        sut.add(move)
        
        // Assert
        XCTAssertEqual(commandObserver.events, [Recorded.next(0, move)])
        XCTAssertEqual(sut.isEmpty, true)
    }
    
    func test_EmmitMultipleAddedMoves() {
        // Given
        let move1 = GameMove(name: MoveName("m1"), actorId: "px")
        let move2 = GameMove(name: MoveName("m2"), actorId: "px")
        let move3 = GameMove(name: MoveName("m3"), actorId: "px")
        
        let expectation = XCTestExpectation(description: "Emmit all moves")
        var emmitedMoves: [GameMove] = []
        sut.pull().subscribe(onNext: { move in
            emmitedMoves.append(move)
            if emmitedMoves.count == 3 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        // When
        sut.add(move1)
        sut.add(move2)
        sut.add(move3)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(emmitedMoves, [move1, move2, move3])
    }
}
