//
//  DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 17/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests: XCTestCase {

    private let sut = DrawsAnotherCardIfSecondDrawIsRedSuitMatcher()
    
    func test_DrawsAnotherCardIfSecondDrawIsRedSuit_IfHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsAnotherCardIfSecondDrawIsRedSuit: true])
            .holding(MockCardProtocol().suit(is: .clubs), MockCardProtocol().suit(is: .diamonds))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .startTurn, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .drawsAnotherCardIfSecondDrawIsRedSuit, actorId: "p1"))
    }
    
    func test_ExecutingDrawsAnotherCardIfSecondDrawIsRedSuit() {
        // Given
        let move = GameMove(name: .drawsAnotherCardIfSecondDrawIsRedSuit, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: MockGameStateProtocol())
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1")])
    }

}
