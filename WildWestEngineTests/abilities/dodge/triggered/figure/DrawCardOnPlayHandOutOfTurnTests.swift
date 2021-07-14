//
//  DrawCardOnPlayHandOutOfTurnTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 02/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawCardOnPlayHandOutOfTurnTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_drawCardOnPlayHandOutOfTurn_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "drawCardOnPlayHandOutOfTurn")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "pX")
        let event = GEvent.play(player: "p1", card: "c1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawCardOnPlayHandOutOfTurn", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1")])
    }
}
