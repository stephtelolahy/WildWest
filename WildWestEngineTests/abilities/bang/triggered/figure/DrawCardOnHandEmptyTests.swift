//
//  DrawCardOnHandEmptyTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 11/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawCardOnHandEmptyTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_DrawsCard_OnDiscardHandThenEmptyHand() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnHandEmpty")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.discardHand(player: "p1", card: "c1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnHandEmpty", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1")])
    }
    
    func test_DoNothing_OnDiscardHandThenNotEmptyHand() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnHandEmpty")
            .holding(MockCardProtocol())
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.discardHand(player: "p1", card: "c1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_DrawsCard_OnequipThenEmptyHand() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnHandEmpty")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.equip(player: "p1", card: "c1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnHandEmpty", actor: "p1")])
    }
    
    func test_DrawsCard_OnhandicapThenEmptyHand() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnHandEmpty")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.handicap(player: "p1", card: "c1", other: "p2")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnHandEmpty", actor: "p1")])
    }
    
    func test_DrawsCard_OnDrawHandThenEmptyHand() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnHandEmpty")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.drawHand(player: "p2", other: "p1", card: "c1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnHandEmpty", actor: "p1")])
    }
}
