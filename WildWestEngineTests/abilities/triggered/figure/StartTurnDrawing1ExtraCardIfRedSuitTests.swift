//
//  StartTurnDrawing1ExtraCardIfRedSuitTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 13/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_name

import XCTest
import WildWestEngine
import Resolver

class startTurnDrawing1ExtraCardIfRedSuitTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_DrawsAnotherCardIfSecondDrawIsRedSuit() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnDrawing1ExtraCardIfRedSuit")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .deck(are: MockCardProtocol().withDefault().identified(by: "c1").suit(is: "♣️"),
                  MockCardProtocol().withDefault().identified(by: "c2").suit(is: "♥️"))
        let event: GEvent = .emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawing1ExtraCardIfRedSuit", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1"),
                                .drawDeck(player: "p1"),
                                .revealHand(player: "p1", card: "c2"),
                                .drawDeck(player: "p1"),
                                .setPhase(value: 2)])
    }
    
    func test_DoNotDrawsAnotherCardIfSecondDrawIsNotRedSuit() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnDrawing1ExtraCardIfRedSuit")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .deck(are: MockCardProtocol().withDefault().identified(by: "c1").suit(is: "diamonds"),
                  MockCardProtocol().withDefault().identified(by: "c2").suit(is: "♠️"))
        let event: GEvent = .emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawing1ExtraCardIfRedSuit", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1"),
                                .drawDeck(player: "p1"),
                                .revealHand(player: "p1", card: "c2"),
                                .setPhase(value: 2)])
    }
}
