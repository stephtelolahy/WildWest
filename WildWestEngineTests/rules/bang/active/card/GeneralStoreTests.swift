//
//  GeneralStoreTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class GeneralStoreTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayGeneralStore_IfYourTurn() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "generalstore")
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
        XCTAssertEqual(moves, [GMove("generalstore", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .deckToStore,
                                .deckToStore,
                                .deckToStore,
                                .addHit(hits: [GHit(player: "p1", name: "generalstore", abilities: ["drawStore"], offender: "p1"),
                                               GHit(player: "p2", name: "generalstore", abilities: ["drawStore"], offender: "p1"),
                                               GHit(player: "p3", name: "generalstore", abilities: ["drawStore"], offender: "p1")])])
    }
}
