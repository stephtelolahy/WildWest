//
//  BangRequire2CardsTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 08/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class BangRequire2CardsTests: XCTestCase {

    private let sut: GameRulesProtocol = Resolver.resolve()

    func test_CanBangRequire2Cards_IfHavingAbility() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "bangRequire2Cards")
            .holding(mockCard1, mockCard2)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
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
        XCTAssertEqual(moves, [GMove("bangRequire2Cards", actor: "p1", args: [.requiredHand: ["c1", "c2"], .target: ["p2"]])])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .addHit(hits: [GHit(player: "p2", name: "bangRequire2Cards", abilities: ["looseHealth"], offender: "p1", cancelable: 1)])])
    }
    
    func test_CannotBangRequire2Cards_IfAlreadyPlayedOnce() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "bangRequire2Cards")
            .holding(mockCard1, mockCard2)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .played(are: "bangRequire2Cards")
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }

}
