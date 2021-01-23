//
//  DuelTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DuelTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayDuel_IfOwnCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "duel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("duel", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(name: "duel", player: "p2", abilities: ["looseHealth"], cancelable: 0, offender: "p1")])
    }
}
