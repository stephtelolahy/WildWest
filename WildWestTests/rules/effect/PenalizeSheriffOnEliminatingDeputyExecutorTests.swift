//
//  PenalizeSheriffOnEliminatingDeputyExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PenalizeSheriffOnEliminatingDeputyExecutorTests: XCTestCase {

    private let sut = PenalizeSheriffOnEliminatingDeputyExecutor()

    func test_DiscardAllCards_IfPenalizedSheriffOnEliminatingDeputy() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1")
        let mockCard2 = MockCardProtocol().identified(by: "c2")
        let mockCard3 = MockCardProtocol().identified(by: "c3")
        let mockCard4 = MockCardProtocol().identified(by: "c4")
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
            .playing(mockCard3, mockCard4)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .penalizeSheriffOnEliminatingDeputy, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2"),
                                 .playerDiscardInPlay("p1", "c3"),
                                 .playerDiscardInPlay("p1", "c4")])
    }
}
