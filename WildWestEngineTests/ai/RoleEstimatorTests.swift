//
//  RoleEstimatorTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo

class RoleEstimatorTests: XCTestCase {

    private var sut: RoleEstimatorProtocol!
    private var mockAbilityEvaluator: MockAbilityEvaluatorProtocol!
    
    override func setUp() {
        mockAbilityEvaluator = MockAbilityEvaluatorProtocol()
        sut = RoleEstimator(sheriff: "sheriff", abilityEvaluator: mockAbilityEvaluator)
    }
    
    func test_InitialEstimatedRoleIsUnknown() {
        // Given
        // When
        // Assert
        XCTAssertNil(sut.estimatedRole(for: "p1"))
    }
    
    func test_InitialScoreIsZero() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.score(for: "p1"), 0)
    }
    
    func test_ConsiderOutlaw_IfAttackingSheriff() {
        // Given
        let move = GMove("a1", actor: "p1", args: [.target: ["sheriff"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(3)
        }
        
        // When
        sut.update(on: move)
        
        // Assert
        XCTAssertEqual(sut.estimatedRole(for: "p1"), .outlaw)
    }
    
    func test_ConsiderDeputy_IfDefindingSheriff() {
        // Given
        let move = GMove("a2", actor: "p1", args: [.target: ["sheriff"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(-1)
        }
        
        // When
        sut.update(on: move)
        
        // Assert
        XCTAssertEqual(sut.estimatedRole(for: "p1"), .deputy)
    }
    
    func test_ConsiderUnknown_IfNotTargetingSheriff() {
        // Given
        // When
        sut.update(on: GMove("a1", actor: "p1", args: [.target: ["p2"]]))
        
        // Assert
        XCTAssertNil(sut.estimatedRole(for: "p1"))
    }
    
    func test_UpdateScore_IfTargetingSheriff() {
        // Given
        let move = GMove("a1", actor: "p1", args: [.target: ["sheriff"]])
        stub(mockAbilityEvaluator) { mock in
            when(mock.evaluate(equal(to: move))).thenReturn(1)
        }
        
        // When
        sut.update(on: move)
        
        // Assert
        XCTAssertEqual(sut.score(for: "p1"), 1)
    }
}
