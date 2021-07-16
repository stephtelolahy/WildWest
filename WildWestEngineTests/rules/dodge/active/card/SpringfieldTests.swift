//
//  SpringfieldTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 24/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class SpringfieldTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlaySpringfield_IfOtherIsAtAnyDistance() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "springfield")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
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
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("springfield", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"], .target: ["p2"]]),
                               GMove("springfield", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"], .target: ["p3"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .addHit(hits: [GHit(player: "p2", name: "springfield", abilities: ["looseHealth"], offender: "p1", cancelable: 1)])])
    }
}
