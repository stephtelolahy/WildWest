//
//  DiscardBangOnDuelTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DiscardBangOnDuelTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanDiscardBang_ToReverseHit_IfHitByDuel() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .named("bang")
            .type(is: .brown)
            .abilities(are: "discardBangOnDuel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .named("duel")
            .player(is: "p1")
            .offender(is: "p2")
            .abilities(are: "looseHealth")
            .cancelable(is: 0)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hits(are: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardBangOnDuel", actor: "p1", card: .hand("c1")),
                               GMove("looseHealth", actor: "p1")])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .removeHit(player: "p1"),
                                .addHit(hits: [GHit(player: "p2", name: "duel", abilities: ["looseHealth"], offender: "p1")])])
    }
}
