//
//  GameUpdate+AnimatableTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 16/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameUpdate_AnimatableTests: XCTestCase {
    
    func test_SplitByExecutionTime() {
        // Given
        let update1 : GameUpdate = .flipOverFirstDeckCard
        let update0 : GameUpdate = .setChallenge(nil)
        
        // When
        // Assert
        
        // Empty group updates
        XCTAssertEqual([GameUpdate]().splitByExecutionTime(), [])
        
        // One group updates
        XCTAssertEqual([update0, update0, update0].splitByExecutionTime(), [[update0, update0, update0]])
        XCTAssertEqual([update1, update0, update0].splitByExecutionTime(), [[update1, update0, update0]])
        XCTAssertEqual([update0, update0, update1].splitByExecutionTime(), [[update0, update0, update1]])
        XCTAssertEqual([update0, update1, update0].splitByExecutionTime(), [[update0, update1, update0]])
        
        // Two group updates
        XCTAssertEqual([update1, update0, update1].splitByExecutionTime(), [[update1, update0], [update1]])
        XCTAssertEqual([update1, update1, update0].splitByExecutionTime(), [[update1], [update1, update0]])
        XCTAssertEqual([update0, update1, update1].splitByExecutionTime(), [[update0, update1], [update1]])
        
        // Three group of updates
        XCTAssertEqual([update1, update1, update1].splitByExecutionTime(), [[update1], [update1], [update1]])
    }
}
