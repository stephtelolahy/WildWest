//
//  GEventQueueTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 31/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine

class GEventQueueTests: XCTestCase {
    
    private var sut: GEventQueueProtocol!
    
    override func setUp() {
        sut = GEventQueue()
    }
    
    func test_ReturnEmptyQueueThenNil_IfInitialValue() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.pop(), .emptyQueue)
        XCTAssertNil(sut.pop())
    }
    
    func test_ReturnsSuccessivelyQueuedEvents_IfPop() {
        // Given
        let event1: GEvent = .deckToStore 
        let event2: GEvent = .drawStore(player: "p1", card: "c1")
        let event3: GEvent = .removeHit(player: "p1")
        let event0: GEvent = .discardHand(player: "p1", card: "c2")
        
        // When
        sut.queue(event1)
        sut.queue(event2)
        sut.queue(event3)
        sut.push(event0)
        
        // Assert
        XCTAssertEqual(sut.pop(), event0)
        XCTAssertEqual(sut.pop(), event1)
        XCTAssertEqual(sut.pop(), event2)
        XCTAssertEqual(sut.pop(), event3)
        XCTAssertEqual(sut.pop(), .emptyQueue)
        XCTAssertNil(sut.pop())
    }
    
    func test_EmitEmptyQueue_IfPoppingAfterLastPushedEvent() {
        // Given
        let event0: GEvent = .drawDeck(player: "p1")
        
        // When
        sut.push(event0)
        
        // Assert
        XCTAssertEqual(sut.pop(), event0)
        XCTAssertEqual(sut.pop(), .emptyQueue)
        XCTAssertNil(sut.pop())
    }
    
    func test_EmitEmptyQueue_IfPoppingAfterLastQueuedEvent() {
        // Given
        let event0: GEvent = .drawDeck(player: "p1")
        
        // When
        sut.queue(event0)
        
        // Assert
        XCTAssertEqual(sut.pop(), event0)
        XCTAssertEqual(sut.pop(), .emptyQueue)
        XCTAssertNil(sut.pop())
    }
    
    func test_EmitEmptyQueue_IfOncePoppingEmptyQueue() {
        // Given
        let event1: GEvent = .deckToStore 
        let event2: GEvent = .drawStore(player: "p1", card: "c1")
        
        // When
        // Assert
        // Given
        sut.queue(event1)
        XCTAssertEqual(sut.pop(), event1)
        XCTAssertEqual(sut.pop(), .emptyQueue)
        sut.queue(event2)
        XCTAssertEqual(sut.pop(), event2)
        XCTAssertEqual(sut.pop(), .emptyQueue)
        XCTAssertNil(sut.pop())
        XCTAssertNil(sut.pop())
    }
    
}
