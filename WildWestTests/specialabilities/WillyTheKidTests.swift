//
//  WillyTheKidTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class WillyTheKidTests: XCTestCase {
    
    func test_WillyTheKidHasNoLimitOnBangsPerTurn() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .willyTheKid)
            .noCardsInPlay()
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
}
