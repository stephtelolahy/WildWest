//
//  PlayBangAsMissedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 01/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PlayBangAsMissedTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayBangAsMissed_IfHavingAttribute() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .named("bang")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .attributes(is: MockCardAttributesProtocol().withDefault().playAs(is: ["bang": "missed"]))
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
