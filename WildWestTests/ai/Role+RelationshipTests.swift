//
//  Role+RelationshipTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 06/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class Role_RelationshipTests: XCTestCase {
    
    func test_SheriffBehaviour() {
        // Given
        let sut = Role.sheriff
        // When
        // Assert
        XCTAssertEqual(sut.relationShip(to: nil), .unknown)
        XCTAssertEqual(sut.relationShip(to: .outlaw), .enemy)
    }
    
    func test_OutlawBehaviour() {
        // Given
        let sut = Role.outlaw
        // When
        // Assert
        XCTAssertEqual(sut.relationShip(to: nil), .unknown)
        XCTAssertEqual(sut.relationShip(to: .sheriff), .enemy)
        XCTAssertEqual(sut.relationShip(to: .outlaw), .teammate)
    }
    
    func test_DeputyBehaviour() {
        func test_RenegateBehaviour_When2Players() {
            // Given
            let sut = Role.deputy
            // When
            // Assert
            XCTAssertEqual(sut.relationShip(to: nil), .unknown)
            XCTAssertEqual(sut.relationShip(to: .sheriff), .teammate)
            XCTAssertEqual(sut.relationShip(to: .outlaw), .enemy)
        }
    }
    
    func test_RenegateBehaviour() {
        // Given
        let sut = Role.renegade
        // When
        // Assert
        XCTAssertEqual(sut.relationShip(to: nil), .unknown)
        XCTAssertEqual(sut.relationShip(to: .sheriff, playersCount: 3), .teammate)
        XCTAssertEqual(sut.relationShip(to: .sheriff, playersCount: 2), .enemy)
        XCTAssertEqual(sut.relationShip(to: .outlaw), .unknown)
    }
}
