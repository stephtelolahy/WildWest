//
//  Draw2CardsOnOtherEliminatedTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Draw2CardsOnOtherEliminatedTests: XCTestCase {

    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_Draw2CardsOnOtherEliminated_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "draw2CardsOnOtherEliminated")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("draw2CardsOnOtherEliminated", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1"),
                                .drawDeck(player: "p1")])
    }
}
