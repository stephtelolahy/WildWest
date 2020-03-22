//
//  EliminateMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EliminateMatcherTests: XCTestCase {

    private let sut = EliminateMatcher()

    func test_ShouldEliminateActorAfterPass_IfHealthIsZero() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .players(are: player1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .eliminate, actorId: "p1"))
    }
}
