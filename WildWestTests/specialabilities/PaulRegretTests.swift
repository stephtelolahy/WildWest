//
//  PaulRegretTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PaulRegretTests: XCTestCase {

    func test_PaulRegretHasAMustang_AtAllTimes() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .paulRegret)
            .noCardsInPlay()
        
        // When
        // Assert
        XCTAssertEqual(sut.mustangCount, 1)
    }
    
    func test_PaulRegretHasDoubleMustang_IfPlayingMustang() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .paulRegret)
            .playing(MockCardProtocol().named(.mustang))
        
        // When
        // Assert
        XCTAssertEqual(sut.mustangCount, 2)
    }

}
