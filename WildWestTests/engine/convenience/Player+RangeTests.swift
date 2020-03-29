//
//  Player+RangeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class Player_RangeTests: XCTestCase {
    
    func test_DefaultBangsLimitPerTurnIs1() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 1)
    }
    
    func test_UnlimitedBangsPerTurn_IfPlayingVolcanic() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
            .playing(MockCardProtocol().named(.volcanic))
        
        // When
        // Assert
        XCTAssertEqual(sut.bangLimitsPerTurn, 0)
    }
    
    func test_RangeOfDefaultGunIs1() {
        // Given
        let sut = MockPlayerProtocol()
            .withDefault()
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 1)
    }
    
    func test_RangeOfVolcanicIs1() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.volcanic))
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 1)
    }
    
    func test_RangeOfSchofieldIs2() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.schofield))
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 2)
    }
    
    func test_RangeOfRemingtonIs3() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.remington))
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 3)
    }
    
    func test_RangeOfCarabineIs4() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.revCarbine))
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 4)
    }
    
    func test_RangeOfWinchesterIs5() {
        // Given
        let sut = MockPlayerProtocol()
            .playing(MockCardProtocol().named(.winchester))
        
        // When
        // Assert
        XCTAssertEqual(sut.gunRange, 5)
    }
}
