//
//  Gain2HealthOnOtherEliminatedTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Gain2HealthOnOtherEliminatedTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_Gain2HealthOnOtherEliminated_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 1)
            .attributes(are: [.bullets: 4])
            .abilities(are: "gain2HealthOnOtherEliminated")
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
        XCTAssertEqual(moves, [GMove("gain2HealthOnOtherEliminated", actor: "p1")])
        XCTAssertEqual(events, [.gainHealth(player: "p1"),
                                .gainHealth(player: "p1")])
    }
    
    func test_Gain1HealthOnOtherEliminated_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 3)
            .attributes(are: [.bullets: 4])
            .abilities(are: "gain2HealthOnOtherEliminated")
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
        XCTAssertEqual(moves, [GMove("gain2HealthOnOtherEliminated", actor: "p1")])
        XCTAssertEqual(events, [.gainHealth(player: "p1")])
    }
    
}
