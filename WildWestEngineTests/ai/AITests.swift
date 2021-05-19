//
//  AITests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo

class AITests: XCTestCase {

    private var sut: AIProtocol!
    private var mockMoveEvaluator: MockMoveEvaluatorProtocol!
    
    override func setUp() {
        mockMoveEvaluator = MockMoveEvaluatorProtocol()
        sut = GAI(moveEvaluator: mockMoveEvaluator)
    }

    func test_BestMove_IfSingleMove() {
        // Given
        let mockState = MockStateProtocol()
        let move1 = GMove("m1", actor: "p1")
        
        // When
        let best = sut.bestMove(among: [move1], in: mockState)
        
        // Assert
        XCTAssertEqual(best, move1)
    }
    
    func test_BestMove_IfTheOneHavingHighestValue() {
        // Given
        let mockState = MockStateProtocol()
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p1")
        let move3 = GMove("m3", actor: "p1")
        stub(mockMoveEvaluator) { mock in
            when(mock.evaluate(equal(to: move1), in: state(equalTo: mockState))).thenReturn(1)
            when(mock.evaluate(equal(to: move2), in: state(equalTo: mockState))).thenReturn(2)
            when(mock.evaluate(equal(to: move3), in: state(equalTo: mockState))).thenReturn(3)
        }
        
        // When
        let best = sut.bestMove(among: [move1, move2, move3], in: mockState)
        
        // Assert
        XCTAssertEqual(best, move3)
    }
    
    func test_BestMove_IfRandomElementHavingHighestValue() {
        // Given
        let mockState = MockStateProtocol()
        let move1 = GMove("m1", actor: "p1")
        let move2 = GMove("m2", actor: "p1")
        let move3 = GMove("m3", actor: "p1")
        stub(mockMoveEvaluator) { mock in
            when(mock.evaluate(equal(to: move1), in: state(equalTo: mockState))).thenReturn(1)
            when(mock.evaluate(equal(to: move2), in: state(equalTo: mockState))).thenReturn(2)
            when(mock.evaluate(equal(to: move3), in: state(equalTo: mockState))).thenReturn(2)
        }
        
        // When
        let best = sut.bestMove(among: [move1, move2, move3], in: mockState)
        
        // Assert
        XCTAssertTrue(best == move2 || best == move3)
    }
}
