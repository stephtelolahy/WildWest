//
//  Discard2CardsFor1HealthTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 12/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class Discard2CardsFor1HealthTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanDiscard2CardsFor1Life_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discard2CardsFor1Health")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"),
                     MockCardProtocol().withDefault().identified(by: "c2"),
                     MockCardProtocol().withDefault().identified(by: "c3"))
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
        XCTAssertEqual(moves, [GMove("discard2CardsFor1Health", actor: "p1", args: [.requiredHand: ["c1", "c2"]]),
                               GMove("discard2CardsFor1Health", actor: "p1", args: [.requiredHand: ["c1", "c3"]]),
                               GMove("discard2CardsFor1Health", actor: "p1", args: [.requiredHand: ["c2", "c3"]])])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .gainHealth(player: "p1")])
    }
    
    func test_CannotDiscard2CardsFor1Life_IfHavingAbilityButNotEnoughCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discard2CardsFor1Health")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"))
            .health(is: 1)
            .maxHealth(is: 4)
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
