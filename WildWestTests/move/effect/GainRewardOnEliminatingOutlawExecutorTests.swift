//
//  GainRewardOnEliminatingOutlawExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GainRewardOnEliminatingOutlawExecutorTests: XCTestCase {

    private let sut = GainRewardOnEliminatingOutlawExecutor()

    func test_Pull3Cards_IfRewardedOnEliminatingOutlaw() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .gainRewardOnEliminatingOutlaw, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 3)])
    }
}
