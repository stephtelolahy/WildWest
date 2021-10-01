//
//  StartTurnDrawingInPlayTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 08/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class StartTurnDrawingInPlayTests: XCTestCase {

    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_startTurnChoosingDrawInPlay_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnChoosingDrawInPlay")
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
        XCTAssertEqual(moves, [GMove("startTurnChoosingDrawInPlay", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hit: GHit(name: "startTurnChoosingDrawInPlay",
                                                  players: ["p1"],
                                                  abilities: ["startTurnDrawingInPlay", "startTurnDrawingDeck"]))])
    }
    
    func test_CanStartTurnDrawingInPlay() throws {
        // Given
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().withDefault().identified(by: "c1"))
        let mockHit = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .abilities(are: "startTurnDrawingInPlay")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .discard(are: MockCardProtocol().withDefault().identified(by: "c1"))
            .hit(is: mockHit)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawingInPlay", actor: "p1", args: [.target: ["p2"], .requiredInPlay: ["c1"]])])
        XCTAssertEqual(events, [.drawInPlay(player: "p1", other: "p2", card: "c1"),
                                .removeHit(player: "p1"),
                                .setPhase(value: 2)])
    }
}
