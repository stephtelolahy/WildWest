//
//  TequilaTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 25/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class TequilaTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayTequilaToHealAnyOtherPlayer() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "tequila")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .health(is: 2)
            .maxHealth(is: 4)
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
            .health(is: 2)
            .maxHealth(is: 4)
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
        XCTAssertEqual(moves, [GMove("tequila", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"], .target: ["p2"]]),
                               GMove("tequila", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"], .target: ["p3"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .gainHealth(player: "p2")])
    }
    
    func test_CanPlayTequilaToHealSelf() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "tequila")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
            .health(is: 1)
            .maxHealth(is: 3)
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("tequila", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"], .target: ["p1"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .gainHealth(player: "p1")])
    }
}
