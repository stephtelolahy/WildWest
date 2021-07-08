//
//  Draw2CardsRequire1BlueCardTests.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Draw2CardsRequire1BlueCardTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanDraw2CardsRequire1BlueCard_IfHavingAbility() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .blue)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .abilities(are: ["draw2CardsRequire1BlueCard": 0])
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("draw2CardsRequire1BlueCard", actor: "p1", args: [.requiredHand: ["c1"]])])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .drawDeck(player: "p1"),
                                .drawDeck(player: "p1")])
    }
    
    func test_CannotDraw2CardsRequire1BlueCard_IfHavingAbilityButPlayedTwice() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .blue)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .abilities(are: ["draw2CardsRequire1BlueCard": 0])
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
            .played(are: "draw2CardsRequire1BlueCard", "draw2CardsRequire1BlueCard")
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
