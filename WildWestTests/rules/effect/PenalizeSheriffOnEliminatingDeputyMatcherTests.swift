//
//  PenalizeSheriffOnEliminatingDeputyMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PenalizeSheriffOnEliminatingDeputyMatcherTests: XCTestCase {

    private let sut = PenalizeSheriffOnEliminatingDeputyMatcher()

    func test_ShouldPenalizeSheriff_IfEliminatingDeputy() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p2").role(is: .sheriff))
            .eliminated(are: MockPlayerProtocol().identified(by: "p1").role(is: .deputy))
            .damageEvents(are: DamageEvent(playerId: "p1", source: .byPlayer("p2")))
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .penalizeSheriffOnEliminatingDeputy, actorId: "p2"))
    }
}
