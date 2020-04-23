//
//  DrawsCardFromPlayerDamagedHimMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsCardFromPlayerDamagedHimMatcherTests: XCTestCase {
    
    private let sut = DrawsCardFromPlayerDamagedHimMatcher()
    
    func test_ShouldDrawsCardFromPlayerDamagedHim() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardFromPlayerDamagedHim: true])
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p2")))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .drawsCardFromPlayerDamagedHim, actorId: "p1", cardId: "c2", targetId: "p2"))
    }
    
    func test_CannotDrawsCardFromPlayerDamagedHimIfHandsEmpty() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardFromPlayerDamagedHim: true])
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p1")))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .noCardsInHand()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertNil(effect)
    }
    
    func test_CannotDrawsCardFromPlayerDamagedHimIfHimself() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.drawsCardFromPlayerDamagedHim: true])
            .lastDamage(is: DamageEvent(damage: 1, source: .byPlayer("p1")))
            .holding(MockCardProtocol().identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertNil(effect)
    }
    
    func test_DrawsACardOnOffenderHand() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .drawsCardFromPlayerDamagedHim, actorId: "p1", cardId: "c2", targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromOtherHand("p1", "p2", "c2")])
    }
}
