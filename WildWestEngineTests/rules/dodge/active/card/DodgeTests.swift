//
//  DodgeTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DodgeTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayDodgeToCancelAndDrawDeck_IfHitByBang() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "dodge")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hit(is: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("dodge", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .removeHit(player: "p1"),
                                .drawDeck(player: "p1")])
    }
}
