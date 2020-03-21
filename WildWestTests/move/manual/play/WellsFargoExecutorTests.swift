//
//  WellsFargoExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class WellsFargoExecutorTests: XCTestCase {
    
    private let sut = WellsFargoExecutor()
    
    func test_Pull3Cards_IfPlayingWellsFargo() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .wellsFargo)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromDeck("p1", 3)])
    }
}
