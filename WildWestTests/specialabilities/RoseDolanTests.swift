//
//  RoseDolanTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class RoseDolanTests: XCTestCase {

    func test_RoseDolanHasAScope_AtAllTimes() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .roseDoolan)
            .noCardsInPlay()
        
        // When
        // Assert
        XCTAssertEqual(sut.scopeCount, 1)
    }

    func test_RoseDolanHasDoubleScope_IfPlayingScope() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .roseDoolan)
            .playing(MockCardProtocol().named(.scope))
        
        // When
        // Assert
        XCTAssertEqual(sut.scopeCount, 2)
    }
}
