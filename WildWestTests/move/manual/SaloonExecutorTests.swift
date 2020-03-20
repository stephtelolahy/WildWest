//
//  SaloonExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class SaloonExecutorTests: XCTestCase {

    private let sut = SaloonExecutor()
    
    func test_OnlyNotMaxHealthPlayerGainLifePoints_IfPlayingSaloon() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .maxHealth(is: 4)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 3)
            .maxHealth(is: 4)
        let mockPlayer3 = MockPlayerProtocol()
            .identified(by: "p3")
            .health(is: 3)
            .maxHealth(is: 3)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        let move = GameMove(name: .playCard, actorId: "p1", cardId: "c1", cardName: .saloon)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerGainHealth("p1", 1),
                                 .playerGainHealth("p2", 1)])
    }
}
