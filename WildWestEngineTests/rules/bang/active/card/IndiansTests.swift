//
//  IndiansTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 05/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class IndiansTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayIndians_IfOwnCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "indians")
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
            .playOrder(is: "p1", "p2", "p3")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("indians", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(hits: [GHit(player: "p2", name: "indians", abilities: ["looseHealth"], offender: "p1"),
                                               GHit(player: "p3", name: "indians", abilities: ["looseHealth"], offender: "p1")])])
    }
}
