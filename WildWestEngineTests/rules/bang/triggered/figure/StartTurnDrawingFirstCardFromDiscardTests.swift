//
//  StartTurnChoosingDrawDiscardTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 16/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class StartTurnChoosingDrawDiscardTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_StartTurnChoosingDrawDiscard_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnChoosingDrawDiscard")
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
        XCTAssertEqual(moves, [GMove("startTurnChoosingDrawDiscard", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hit: GHit(name: "startTurnChoosingDrawDiscard",
                                                  players: ["p1"],
                                                  abilities: ["startTurnDrawingDiscard", "startTurnDrawingDeck"]))])
    }
    
    func test_CanStartTurnDrawingDiscard() throws {
        // Given
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockHit = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .abilities(are: "startTurnDrawingDiscard")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .discard(are: MockCardProtocol().withDefault().identified(by: "c1"))
            .hit(is: mockHit)
        
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
