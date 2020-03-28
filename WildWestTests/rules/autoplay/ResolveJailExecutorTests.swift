//
//  ResolveJailExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StayInJailExecutorTests: XCTestCase {

    private let sut = StayInJailExecutor()
    
    func test_SkipTurn_IfStayInJail() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1"), MockPlayerProtocol().identified(by: "p2"))
            .currentTurn(is: "p1")
        let move = GameMove(name: .stayInJail, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1"),
                                 .setTurn("p2"),
                                 .setChallenge(.startTurn)])
    }
}

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
