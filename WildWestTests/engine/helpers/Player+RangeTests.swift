//
//  Player+RangeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class Player_RangeTests: XCTestCase {
    
    private let sut = MockPlayerProtocol()

    func test_DefaultMaxNumberOfShootsIs1() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.inPlay.get).thenReturn([])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 1)
    }
    
    func test_IllimitedNumberOfShoots_IfPlayingVolcanic() {
        // Given
        Cuckoo.stub(sut) { mock in
            when(mock.inPlay.get).thenReturn([
                MockCardProtocol().named(.volcanic)
            ])
        }
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }

}
