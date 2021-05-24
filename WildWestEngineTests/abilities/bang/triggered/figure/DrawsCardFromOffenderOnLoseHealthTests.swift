//
//  DrawsCardFromOffenderOnLoseHealthTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 11/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawsCardFromOffenderOnLoseHealthTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_DrawsCardFromPlayerDamagedHim() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsCardFromOffenderOnLoseHealth")
            .health(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.looseHealth(player: "p1", offender: "p2")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawsCardFromOffenderOnLoseHealth", actor: "p1", args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.drawHand(player: "p1", other: "p2", card: "c2")])
    }
    
    func test_CannotDrawsCardFromPlayerDamagedHimIfHandsEmpty() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsCardFromOffenderOnLoseHealth")
            .health(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.looseHealth(player: "p1", offender: "p2")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotDrawsCardFromPlayerDamagedHimIfHimself() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawsCardFromOffenderOnLoseHealth")
            .health(is: 1)
            .holding(MockCardProtocol().identified(by: "c1"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.looseHealth(player: "p1", offender: "p1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
