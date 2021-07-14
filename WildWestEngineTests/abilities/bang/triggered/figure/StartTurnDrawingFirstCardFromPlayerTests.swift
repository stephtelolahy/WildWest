//
//  StartTurnChoosingDrawPlayerTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 16/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class StartTurnChoosingDrawPlayerTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_TriggerHitStartTurnDrawsFirstCardFromOtherPlayer() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnChoosingDrawPlayer")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnChoosingDrawPlayer", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hits: [GHit(player: "p1",
                                                    name: "startTurnChoosingDrawPlayer",
                                                    abilities: ["startTurnDrawingPlayer", "startTurnDrawingDeck"],
                                                    offender: "p1")])])
    }
    
    func test_CanStartTurnDrawingFirstCardFromOtherPlayer() throws {
        // Given
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().withDefault().identified(by: "c2"))
        let mockHit = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "startTurnDrawingPlayer")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .hits(are: mockHit)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawingPlayer", actor: "p1", args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.drawHand(player: "p1", other: "p2", card: "c2"),
                                .drawDeck(player: "p1"),
                                .removeHit(player: "p1"), 
                                .setPhase(value: 2)])
    }
}
