//
//  DrawStoreTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DrawStoreTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_drawStore() throws {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1")
        let mockCard2 = MockCardProtocol().identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .abilities(are: "drawStore")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hit(is: mockHit1)
            .store(are: mockCard1, mockCard2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawStore", actor: "p1", args: [.requiredStore: ["c1"]]),
                               GMove("drawStore", actor: "p1", args: [.requiredStore: ["c2"]])])
        XCTAssertEqual(events, [.drawStore(player: "p1", card: "c1"),
                                .removeHit(player: "p1")])
    }
    
}
