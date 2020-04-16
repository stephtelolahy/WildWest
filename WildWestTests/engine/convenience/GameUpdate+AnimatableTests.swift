//
//  GameUpdate+AnimatableTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 16/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GameUpdate_AnimatableTests: XCTestCase {
    
    func test_SplitAnimatables() {
        // Given
        let anim : GameUpdate = .flipOverFirstDeckCard
        let notAnim : GameUpdate = .setChallenge(nil)
        let empty: [GameUpdate] = []
        
        // When
        // Assert
        
        // Empty group updates
        XCTAssertEqual(empty.splitAnimatables(), [])
        
        // One group updates
        XCTAssertEqual([notAnim, notAnim, notAnim].splitAnimatables(), [[notAnim, notAnim, notAnim]])
        XCTAssertEqual([anim, notAnim, notAnim].splitAnimatables(), [[anim, notAnim, notAnim]])
        XCTAssertEqual([notAnim, notAnim, anim].splitAnimatables(), [[notAnim, notAnim, anim]])
        XCTAssertEqual([notAnim, anim, notAnim].splitAnimatables(), [[notAnim, anim, notAnim]])
        
        // Two group updates
        XCTAssertEqual([anim, notAnim, anim].splitAnimatables(), [[anim, notAnim], [anim]])
        XCTAssertEqual([anim, anim, notAnim].splitAnimatables(), [[anim], [anim, notAnim]])
        XCTAssertEqual([notAnim, anim, anim].splitAnimatables(), [[notAnim, anim], [anim]])
        
        // Three group of updates
        XCTAssertEqual([anim, anim, anim].splitAnimatables(), [[anim], [anim], [anim]])
    }
}
