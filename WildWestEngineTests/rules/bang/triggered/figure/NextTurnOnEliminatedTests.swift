//
//  NextTurnOnEliminatedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 10/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class NextTurnOnEliminatedTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_NextPlayer_IfTurnPlayerIsEliminated() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "nextTurnOnEliminated")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p2")
            .initialOrder(is: "p1", "p2")
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("nextTurnOnEliminated", actor: "p1")])
        XCTAssertEqual(events, [.setTurn(player: "p2"),
                                .setPhase(value: 1)])
    }
    
    func test_DoNothing_IfNotTurnPlayerIsEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "nextTurnOnEliminated")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p2")
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p2")
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
