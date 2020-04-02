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
    
    func test_ShouldDrawsACardOnLoseHealth() {
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
    
    
    func test_ShouldNotDrawsACardIfEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardOnLoseHealth: true])
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertNil(effect)
    }
    
    func test_DrawsACardOnLoseHealthByPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardOnLoseHealth: true])
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .damageEvents(are: DamageEvent(playerId: "p1", source: .byPlayer("p1")))
        let move = GameMove(name: .drawsCardOnLoseHealth, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 1)])
    }
    
    func test_Draws3CardsOnLoseHealthByDynamite() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardOnLoseHealth: true])
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .damageEvents(are: DamageEvent(playerId: "p1", source: .byDynamite))
        let move = GameMove(name: .drawsCardOnLoseHealth, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromDeck("p1", 3)])
    }
}
