//
//  DiscardAllCardsOnEliminatedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 10/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DiscardAllCardsOnEliminatedTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_DiscardAllHandCards_IfEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardAllCardsOnEliminated")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"),
                     MockCardProtocol().withDefault().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardAllCardsOnEliminated", actor: "p1")])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2")])
    }
    
    func test_DiscardAllInPlayCards_IfEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardAllCardsOnEliminated")
            .playing(MockCardProtocol().withDefault().identified(by: "c3"),
                     MockCardProtocol().withDefault().identified(by: "c4"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardAllCardsOnEliminated", actor: "p1")])
        XCTAssertEqual(events, [.discardInPlay(player: "p1", card: "c3"),
                                .discardInPlay(player: "p1", card: "c4")])
    }
    
    func test_DoNothing_IfEliminatedWithoutCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardAllCardsOnEliminated")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
