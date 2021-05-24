//
//  PunchTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PunchTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayPunch_IfOtherIsAtDistanceOf1() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "punch")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p1", "p2", "p3")
            .distance(from: "p1", to: "p2", is: 1)
            .distance(from: "p1", to: "p3", is: 3)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("punch", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(players: ["p2"], name: "punch", abilities: ["looseHealth"], cancelable: 1, offender: "p1")])
    }
}

