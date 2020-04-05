//
//  DrawsCardOnLoseHealthMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsCardOnLoseHealthMatcherTests: XCTestCase {
    
    private let sut = DrawsCardOnLoseHealthMatcher()
    
    func test_ShouldDrawsCardOnLoseHealth() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardOnLoseHealth: true])
            .health(is: 2)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .drawsCardOnLoseHealth, actorId: "p1"))
    }
    
    func test_DrawsACardOnLoseHealthByPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p1")))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .drawsCardOnLoseHealth, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 1)])
    }
}
