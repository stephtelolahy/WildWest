//
//  EscapeFromJailExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EscapeFromJailExecutorTests: XCTestCase {

    private let sut = EscapeFromJailExecutor()

    func test_DiscardJail_IfEscapeFromJail() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .escapeFromJail, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1")])
    }
}
