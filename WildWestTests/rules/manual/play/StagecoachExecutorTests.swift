//
//  StagecoachExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StagecoachExecutorTests: XCTestCase {

    private let sut = StagecoachExecutor()
    
    func test_Pull2Cards_IfPlayingStagecoach() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .stagecoach)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromDeck("p1", 2)])
    }

}
