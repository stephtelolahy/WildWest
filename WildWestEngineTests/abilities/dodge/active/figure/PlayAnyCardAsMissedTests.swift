//
//  PlayAnyCardAsMissedTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 27/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PlayAnyCardAsMissedTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayAnyCardAsMissed_IfHavingAttribute() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .abilities(are: ["playAnyCardAsMissed": 0])
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hits(are: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("missed", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .removeHit(player: "p1")])
    }
}
