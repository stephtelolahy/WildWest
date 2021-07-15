//
//  DrawCardOnLoseHealthTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 11/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawCardOnLoseHealthTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_DrawsCard_OnLoseHealth() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 1)
            .abilities(are: "drawCardOnLoseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.looseHealth(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnLoseHealth", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1")])
    }
}
