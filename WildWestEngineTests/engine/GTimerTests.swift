//
//  GTimerTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 31/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo

class GTimerTests: XCTestCase {

    private var sut: GTimerProtocol!
    private var mockMatcher: MockDurationMatcherProtocol!
    
    override func setUp() {
        mockMatcher = MockDurationMatcherProtocol()
        sut = GTimer(matcher: mockMatcher)
    }
    
    func test_WaitDelay_IfEventNotNil() {
        // Given
        let startTime = Date()
        let expectation = XCTestExpectation(description: "completed")
        let event: GEvent = .deckToStore
        stub(mockMatcher) { mock in
            when(mock.waitDuration(equal(to: event))).thenReturn(0.6)
        }
        
        // When
        sut.wait(.deckToStore) {
            if Date().timeIntervalSince(startTime) > 0.5 {
                expectation.fulfill()
            }
        }
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
}
