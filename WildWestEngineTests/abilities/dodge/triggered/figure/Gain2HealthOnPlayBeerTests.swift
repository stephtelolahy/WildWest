//
//  Gain2HealthOnPlayBeerTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Gain2HealthOnPlayBeerTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_GainTwoHealthOnPlayBeer_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 1)
            .attributes(are: [.bullets: 4])
            .abilities(are: "gain2HealthOnPlayBeer")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.play(player: "p1", card: "beer-6♥️")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("gain2HealthOnPlayBeer", actor: "p1")])
        XCTAssertEqual(events, [.gainHealth(player: "p1")])
    }
    
}
