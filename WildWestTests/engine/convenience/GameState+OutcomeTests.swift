//
//  GameState+OutcomeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameState_OutcomeTests: XCTestCase {
    
    func test_OutlawWins_IfSheriffIsEliminated() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .renegade),
                     MockPlayerProtocol().role(is: .deputy),
                     MockPlayerProtocol().role(is: .outlaw))
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .outlawWin)
    }
    
    func test_RenegateWins_IfIsLastAlive() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .renegade))
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .renegadeWin)
    }
    
    func test_SheriffWins_IfAllOutlawsAreEliminated() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .sheriff),
                     MockPlayerProtocol().role(is: .deputy))
        
        // When
        // Assert
        XCTAssertEqual(sut.claculateOutcome(), .sheriffWin)
    }
    
    func test_NoOutcome_IfSheriffAndOutlawsAreNotEliminated() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .sheriff),
                     MockPlayerProtocol().role(is: .outlaw),
                     MockPlayerProtocol().role(is: .deputy),
                     MockPlayerProtocol().role(is: .renegade))
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
    func test_NoOutcome_IfRenegadeAlive() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .sheriff),
                     MockPlayerProtocol().role(is: .renegade))
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
    func test_NoOutcome_IfOutlawAlive() {
        // Given
        let sut = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().role(is: .sheriff),
                     MockPlayerProtocol().role(is: .outlaw))
        
        // When
        // Assert
        XCTAssertNil(sut.claculateOutcome())
    }
    
}
