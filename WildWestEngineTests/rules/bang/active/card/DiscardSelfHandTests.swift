//
//  DiscardSelfHandTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 10/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DiscardSelfHandTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_discardSelfHand() throws {
        // Given
        let mockCard1 = MockCardProtocol().withDefault().identified(by: "c1")
        let mockCard2 = MockCardProtocol().withDefault().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "discardSelfHand")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hits(are: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardSelfHand", actor: "p1", args: [.requiredHand: ["c1"]]),
                               GMove("discardSelfHand", actor: "p1", args: [.requiredHand: ["c2"]])])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .removeHit(player: "p1")])
    }
}
