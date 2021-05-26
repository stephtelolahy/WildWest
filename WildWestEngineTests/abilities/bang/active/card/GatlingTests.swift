//
//  GatlingTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class GatlingTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayGatling_IfOwnCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "gatling")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol().withDefault().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().withDefault().identified(by: "p3")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p3", "p1", "p2")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("gatling", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(hits: [GHit(player: "p2", name: "gatling", abilities: ["looseHealth"], offender: "p1", cancelable: 1),
                                               GHit(player: "p3", name: "gatling", abilities: ["looseHealth"], offender: "p1", cancelable: 1)])])
    }
}
