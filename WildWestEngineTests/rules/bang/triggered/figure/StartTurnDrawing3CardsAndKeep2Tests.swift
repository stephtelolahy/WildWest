//
//  StartTurnChoosing2CardsFromDeckTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 14/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable line_length

import XCTest
import WildWestEngine
import Resolver

class StartTurnChoosing2CardsFromDeckTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_startTurnChoosing2CardsFromDeck() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnChoosing2CardsFromDeck")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event: GEvent = .emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnChoosing2CardsFromDeck", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hits: [GHit(player: "p1", name: "startTurnChoosing2CardsFromDeck", abilities: ["startTurnDrawingDeckChoosing"], offender: "p1")])])
    }
    
    func test_StartTurnDrawingDeckChoosing() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "startTurnDrawingDeckChoosing")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hits(are: mockHit1)
            .deck(are: MockCardProtocol().identified(by: "c1"),
                  MockCardProtocol().identified(by: "c2"),
                  MockCardProtocol().identified(by: "c3"))
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawingDeckChoosing", actor: "p1", args: [.requiredDeck: ["c1", "c2"]]),
                               GMove("startTurnDrawingDeckChoosing", actor: "p1", args: [.requiredDeck: ["c1", "c3"]]),
                               GMove("startTurnDrawingDeckChoosing", actor: "p1", args: [.requiredDeck: ["c2", "c3"]])])
        XCTAssertEqual(events, [.drawDeckChoosing(player: "p1", card: "c1"),
                                .drawDeckChoosing(player: "p1", card: "c2"),
                                .removeHit(player: "p1"), 
                                .setPhase(value: 2)])
    }
}
