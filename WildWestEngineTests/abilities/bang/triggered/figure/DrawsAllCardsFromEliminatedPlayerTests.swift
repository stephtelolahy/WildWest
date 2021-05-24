//
//  DrawsAllCardsFromEliminatedPlayerTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 12/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawsAllCardsFromEliminatedPlayerTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_TakesAllHandCards_IfPlayerEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsAllCardsFromEliminatedPlayer")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawsAllCardsFromEliminatedPlayer", actor: "p1", args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.drawHand(player: "p1", other: "p2", card: "c1"),
                                .drawHand(player: "p1", other: "p2", card: "c2")])
    }
    
    func test_TakesAllInPlayCards_IfPlayerEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsAllCardsFromEliminatedPlayer")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().withDefault().identified(by: "c3"),
                     MockCardProtocol().withDefault().identified(by: "c4"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawsAllCardsFromEliminatedPlayer", actor: "p1", args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.drawInPlay(player: "p1", other: "p2", card: "c3"),
                                .drawInPlay(player: "p1", other: "p2", card: "c4")])
    }
    
    func test_DoNotTriggerTakesAllHandCards_IfSelfEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsAllCardsFromEliminatedPlayer")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"))
            .playing(MockCardProtocol().withDefault().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
