//
//  StartTurnDrawing3CardsAndKeep2Tests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 14/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable line_length

import XCTest
import WildWestEngine
import Resolver

class StartTurnDrawing3CardsAndKeep2Tests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_startTurnDrawing3CardsAndKeep2() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnDrawing3CardsAndKeep2")
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
        XCTAssertEqual(moves, [GMove("startTurnDrawing3CardsAndKeep2", actor: "p1")])
        XCTAssertEqual(events, [.deckToStore,
                                .deckToStore,
                                .deckToStore,
                                .addHit(players: ["p1"], name: "startTurnDrawing3CardsAndKeep2", abilities: ["startTurnDrawingStore"], cancelable: 0, offender: "p1")])
    }
    
    func test_StartTurnDrawingsStore() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "startTurnDrawingStore")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hits(are: mockHit1)
            .store(are: MockCardProtocol().identified(by: "c1"),
                   MockCardProtocol().identified(by: "c2"),
                   MockCardProtocol().identified(by: "c3"))
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawingStore", actor: "p1", args: [.requiredStore: ["c1", "c2"]]),
                               GMove("startTurnDrawingStore", actor: "p1", args: [.requiredStore: ["c1", "c3"]]),
                               GMove("startTurnDrawingStore", actor: "p1", args: [.requiredStore: ["c2", "c3"]])])
        XCTAssertEqual(events, [.drawStore(player: "p1", card: "c1"),
                                .drawStore(player: "p1", card: "c2"),
                                .storeToDeck(card: "c3"),
                                .removeHit(player: "p1"), 
                                .setPhase(value: 2)])
    }
}
