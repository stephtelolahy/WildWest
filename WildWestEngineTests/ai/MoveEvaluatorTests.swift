//
//  MoveEvaluatorTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo

class MoveEvaluatorTests: XCTestCase {

    private var sut: MoveEvaluatorProtocol!
    private var mockRoleEstimator: MockRoleEstimatorProtocol!
    private var mockRoleStrategy: MockRoleStrategyProtocol!
    private var mockAbilityEvaluator: MockAbilityEvaluatorProtocol!
    
    override func setUp() {
        mockRoleEstimator = MockRoleEstimatorProtocol()
        mockRoleStrategy = MockRoleStrategyProtocol()
        mockAbilityEvaluator = MockAbilityEvaluatorProtocol().withEnabledDefaultImplementation(AbilityEvaluatorProtocolStub())
        sut = MoveEvaluator(abilityEvaluator: mockAbilityEvaluator, 
                            roleEstimator: mockRoleEstimator, 
                            roleStrategy: mockRoleStrategy)
    }
    
    func test_Return0_IfAbilityScoreIs0() {
        // Given
        let move = GMove("a1", actor: "p1", args: [.target: ["p2"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(0)
        }
        
        // When
        let value = sut.evaluate(move, in: MockStateProtocol().withDefault())
        
        // Assert
        XCTAssertEqual(value, 0)
        verifyNoMoreInteractions(mockRoleEstimator)
        verifyNoMoreInteractions(mockRoleStrategy)
    }
    
    func test_EvaluateMoveTargetingKnownRole() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .role(is: .outlaw)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GMove("a1", actor: "p1", args: [.target: ["p2"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(3)
        }
        stub(mockRoleStrategy) { mock in
            when(mock).relationship(of: equal(to: .outlaw), to: equal(to: .sheriff), in: state(equalTo: mockState)).thenReturn(1)
        }
        
        // When
        let value = sut.evaluate(move, in: mockState)
        
        // Assert
        XCTAssertEqual(value, 3)
        verifyNoMoreInteractions(mockRoleEstimator)
    }
    
    func test_EvaluateMoveTargetingEstimatedRole() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .role(is: .outlaw)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let moveHistory = GMove("a1", actor: "p1")
        let mockState = MockStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
            .moveHistory(are: moveHistory)
        let move = GMove("a1", actor: "p1", args: [.target: ["p2"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(3)
        }
        stub(mockRoleEstimator) { mock in
            when(mock.estimatedRole(for: "p2", history: any())).thenReturn(.outlaw)
        }
        stub(mockRoleStrategy) { mock in
            when(mock).relationship(of: equal(to: .outlaw), to: equal(to: .outlaw), in: state(equalTo: mockState)).thenReturn(-1)
        }
        
        // When
        let value = sut.evaluate(move, in: mockState)
        
        // Assert
        XCTAssertEqual(value, -3)
        verify(mockRoleEstimator).estimatedRole(for: "p2", history: equal(to: [moveHistory]))
    }
    
    func test_EvaluateMoveTargetingNoRole() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .role(is: .outlaw)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GMove("a1", actor: "p1", args: [.target: ["p2"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(3)
        }
        stub(mockRoleEstimator) { mock in
            when(mock.estimatedRole(for: "p2", history: any())).thenReturn(nil)
        }
        
        // When
        let value = sut.evaluate(move, in: mockState)
        
        // Assert
        XCTAssertEqual(value, 0)
        verifyNoMoreInteractions(mockRoleStrategy)
    }
}
