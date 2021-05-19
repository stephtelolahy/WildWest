//
//  LooseHealthTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class LooseHealthTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()

    func test_CanLooseHealth_IfHit() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .offender(is: "pX")
            .abilities(are: "looseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)

        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)

        // Assert
        XCTAssertEqual(moves, [GMove("looseHealth", actor: "p1")])
        XCTAssertEqual(events, [.looseHealth(player: "p1", offender: "pX"),
                                .removeHit(player: "p1")])
    }
    
    func test_Eliminate_IfLoosingLastHealth() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .health(is: 1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .offender(is: "pX")
            .abilities(are: "looseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)

        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)

        // Assert
        XCTAssertEqual(moves, [GMove("looseHealth", actor: "p1")])
        XCTAssertEqual(events, [.eliminate(player: "p1", offender: "pX"),
                                .removeHit(player: "p1")])
    }
}
