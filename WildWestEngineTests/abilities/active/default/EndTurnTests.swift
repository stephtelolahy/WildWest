//
//  EndTurnTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 30/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class EndTurnTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanEndTurn_IfYourTurnPhase2() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "endTurn")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("endTurn", actor: "p1")])
        XCTAssertEqual(events, [.setPhase(value: 3)])
    }
    
    func test_CannotEndTurn_IfNotPhase2() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "endTurn")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 1)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotEndTurn_IfNotYourTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "endTurn")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .turn(is: "p2")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
