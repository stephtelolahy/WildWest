//
//  StartTurnDrawingFirstCardFromDiscardTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 16/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_name

import XCTest
import WildWestEngine
import Resolver

class StartTurnDrawingFirstCardFromDiscardTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_StartTurnDrawingFirstCardFromDiscard_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnDrawingFirstCardFromDiscard")
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
        XCTAssertEqual(moves, [GMove("startTurnDrawingFirstCardFromDiscard", actor: "p1")])
        XCTAssertEqual(events, [.addHit(players: ["p1"],
                                        name: "startTurnDrawingFirstCardFromDiscard", 
                                        abilities: ["startTurnDrawingDiscard", "startTurnDrawingDeck"], 
                                        cancelable: 0, 
                                        offender: "p1")])
    }
    
    func test_CanStartTurnDrawingDiscard() throws {
        // Given
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockHit = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "startTurnDrawingDiscard")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: MockCardProtocol().withDefault().identified(by: "c1"))
            .hits(are: mockHit)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawingDiscard", actor: "p1")])
        XCTAssertEqual(events, [.drawDiscard(player: "p1"),
                                .drawDeck(player: "p1"),
                                .removeHit(player: "p1"), 
                                .setPhase(value: 2)])
    }
}
