//
//  StartTurnExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StartTurnExecutorTests: XCTestCase {
    
    private let sut = StartTurnExecutor()
    
    func test_Pull2CardsFromDeck_IfStartingTurn() {
        // Given
        // When
        let updates = sut.execute(.startTurn(actorId: "p1"), in: MockGameStateProtocol())
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 2),
                                 .setChallenge(nil)])
    }
    
}
