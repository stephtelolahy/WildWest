//
//  RoleStrategyTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import XCTest
import WildWestEngine
import Cuckoo

class RoleStrategyTests: XCTestCase {
    
    private var sut: RoleStrategyProtocol!
    private var mockState: MockStateProtocol!
    
    override func setUp() {
        mockState = MockStateProtocol()
        sut = RoleStrategy()
    }
    
    func test_SheriffStrategy() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.relationship(of: .sheriff, to: .outlaw, in: mockState), 1)
        XCTAssertEqual(sut.relationship(of: .sheriff, to: .deputy, in: mockState), -1)
        XCTAssertEqual(sut.relationship(of: .sheriff, to: .renegade, in: mockState), 0)
    }
    
    func test_OutlawStrategy() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.relationship(of: .outlaw, to: .outlaw, in: mockState), -1)
        XCTAssertEqual(sut.relationship(of: .outlaw, to: .sheriff, in: mockState), 1)
        XCTAssertEqual(sut.relationship(of: .outlaw, to: .deputy, in: mockState), 0)
        XCTAssertEqual(sut.relationship(of: .outlaw, to: .renegade, in: mockState), 0)
    }
    
    func test_DeputyStrategy() {
        // Given
        // When
        // Assert
        XCTAssertEqual(sut.relationship(of: .deputy, to: .sheriff, in: mockState), -1)
        XCTAssertEqual(sut.relationship(of: .deputy, to: .outlaw, in: mockState), 1)
        XCTAssertEqual(sut.relationship(of: .deputy, to: .deputy, in: mockState), -1)
        XCTAssertEqual(sut.relationship(of: .deputy, to: .renegade, in: mockState), 0)
    }
    
    func test_RenegateBehaviour_When3Players() {
        // Given
        stub(mockState) { mock in
            when(mock.playOrder.get).thenReturn(["p1", "p2", "p3"])
        }
        // When
        // Assert
        XCTAssertEqual(sut.relationship(of: .renegade, to: .sheriff, in: mockState), -1)
        XCTAssertEqual(sut.relationship(of: .renegade, to: .outlaw, in: mockState), 1)
        XCTAssertEqual(sut.relationship(of: .renegade, to: .deputy, in: mockState), 1)
        XCTAssertEqual(sut.relationship(of: .renegade, to: .renegade, in: mockState), 0)
    }
    
    func test_RenegateBehaviour_When2Players() {
        // Given
        stub(mockState) { mock in
            when(mock.playOrder.get).thenReturn(["p1", "p2"])
        }
        // When
        // Assert
        XCTAssertEqual(sut.relationship(of: .renegade, to: .sheriff, in: mockState), 1)
    }
}
