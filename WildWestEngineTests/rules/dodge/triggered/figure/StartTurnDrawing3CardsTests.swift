//
//  StartTurnDrawing3CardsTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class StartTurnDrawing3CardsTests: XCTestCase {

    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_StartTurn_IfYourTurnPhase1() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "startTurnDrawing3Cards")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("startTurnDrawing3Cards", actor: "p1")])
        XCTAssertEqual(events, [.drawDeck(player: "p1"),
                                .drawDeck(player: "p1"),
                                .drawDeck(player: "p1"),
                                .setPhase(value: 2)])
    }
}
