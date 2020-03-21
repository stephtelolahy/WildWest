//
//  JailExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class JailExecutorTests: XCTestCase {
    
    private let sut = JailExecutor()
    
    func test_PutCardInPlayOfTargetPlayer_IfPlayingJail() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .jail, targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPutInPlayOfOther("p1", "p2", "c1")])
    }
}
