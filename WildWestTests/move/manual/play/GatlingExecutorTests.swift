//
//  GatlingExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class GatlingExecutorTests: XCTestCase {

    private let sut = GatlingExecutor()

    func test_DiscardCardAndSetChallengeToShootAllOtherPlayersRightDirection_IfPlayingGatling() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
        let move = GameMove(name: .play, actorId: "p2", cardId: "c2", cardName: .gatling)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p2", "c2"),
                                 .setChallenge(.shoot(["p3", "p4", "p1"], .gatling, "p2"))])
    }
}
