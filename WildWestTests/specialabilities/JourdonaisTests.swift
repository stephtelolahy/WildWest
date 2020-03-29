//
//  JourdonaisTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class JourdonaisTests: XCTestCase {

    func test_JourdonaisHasABarrel_AtAllTimes() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .joudonais)
            .noCardsInPlay()
        
        // When
        // Assert
        XCTAssertEqual(sut.barrelsCount, 1)
    }

    func test_JourdonaisHasDoubleBarrel_IfPlayingBarrel() {
        // Given
        let sut = MockPlayerProtocol()
            .ability(is: .joudonais)
            .playing(MockCardProtocol().named(.barrel))
        
        // When
        // Assert
        XCTAssertEqual(sut.barrelsCount, 2)
    }

}
