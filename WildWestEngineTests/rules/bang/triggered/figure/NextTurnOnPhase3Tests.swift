//
//  NextTurnOnPhase3Tests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 03/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class NextTurnOnPhase3Tests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_ChangeTurnToNextPlayer_IfYourTurnPhase3() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "nextTurnOnPhase3")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
            .phase(is: 3)
        let event = GEvent.emptyQueue
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("nextTurnOnPhase3", actor: "p1")])
        XCTAssertEqual(events, [.setTurn(player: "p2"),
                                .setPhase(value: 1)])
    }
}
