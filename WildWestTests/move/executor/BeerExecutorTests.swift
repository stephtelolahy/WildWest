//
//  BeerExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class BeerExecutorTests: XCTestCase {

    private let sut = BeerExecutor()
    
    func test_GainLifePoint_IfPlayingBeer() {
        // Given
        let mockState = MockGameStateProtocol()
        
        // When
        let updates = sut.execute(.beer(actorId: "p1", cardId: "c1"), in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerGainHealth("p1", 1)])
    }

}
