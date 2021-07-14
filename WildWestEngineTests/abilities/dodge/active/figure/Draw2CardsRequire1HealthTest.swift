//
//  Draw2CardsRequire1HealthTest.swift
//  WildWestEngineTests
//
//  Created by TELOLAHY Hugues Stéphano on 05/07/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Draw2CardsRequire1HealthTest: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_Draw2CardsRequire1Health_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "draw2CardsRequire1Health")
            .health(is: 2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("draw2CardsRequire1Health", actor: "p1")])
        XCTAssertEqual(events, [.looseHealth(player: "p1", offender: "p1"),
                                .drawDeck(player: "p1"),
                                .drawDeck(player: "p1")])
    }
    
    func test_CannotDraw2CardsRequire1Health_IfLastHealth() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "draw2CardsRequire1Health")
            .health(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .turn(is: "p1")
            .phase(is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
}
