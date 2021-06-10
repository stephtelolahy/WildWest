//
//  PlayMissedAsBangTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 01/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PlayMissedAsBangTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayMissedAsBang_IfHavingAttribute() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .named("missed")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 1)
            .bangsPerTurn(is: 1)
            .bangsCancelable(is: 1)
            .abilities(are: ["playMissedAsBang": 0])
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .distance(from: "p1", to: "p2", is: 1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("bang", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(hits: [GHit(player: "p2", name: "bang", abilities: ["looseHealth"], offender: "p1", cancelable: 1)])])
    }
}
