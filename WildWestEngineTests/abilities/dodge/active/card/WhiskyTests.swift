//
//  WhiskyTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 25/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class WhiskyTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_Gain2Health_IfPlayingWhisky() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "whisky")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockCard3 = MockCardProtocol()
            .withDefault()
            .identified(by: "c3")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2, mockCard3)
            .health(is: 1)
            .maxHealth(is: 4)
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("whisky", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"]]),
                               GMove("whisky", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c3"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .gainHealth(player: "p1"),
                                .gainHealth(player: "p1")])
    }
    
    #warning("TODO: Test gain only 1 health if playing whisky with 1 damage")
}
