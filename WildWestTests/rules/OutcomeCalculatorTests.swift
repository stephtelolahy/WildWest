//
//  OutcomeCalculatorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 14/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class OutcomeCalculatorTests: XCTestCase {
    
    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        let sut = OutcomeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.outcome(for: [.renegade, .deputy, .outlaw]), .outlawWin)
    }
    
    func test_RenegateWins_IfIsLastNotEliminated() {
        // Given
        let sut = OutcomeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.outcome(for: [.renegade]), .renegadeWin)
    }
    
    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        let sut = OutcomeCalculator()
        
        // When
        // Assert
        XCTAssertEqual(sut.outcome(for: [.sheriff, .deputy, .deputy]), .sheriffWin)
    }
    
    func test_NoOutcome_IfSheriffAndOutlawsAreNotEliminated() {
        // Given
        let sut = OutcomeCalculator()
        
        // When
        // Assert
        XCTAssertNil(sut.outcome(for: [.sheriff, .renegade, .deputy, .outlaw]))
    }
}
