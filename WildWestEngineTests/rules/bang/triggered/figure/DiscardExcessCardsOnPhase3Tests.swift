//
//  DiscardExcessCardsOnPhase3Tests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 10/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DiscardExcessCardsOnPhase3Tests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_ShouldDiscard1ExcessCard_IfAnyOnTurnPhase3() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardExcessCardsOnPhase3")
            .health(is: 1)
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "p1")
        let event = GEvent.setPhase(value: 3)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardExcessCardsOnPhase3", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hit: GHit(name: "discardExcessCardsOnPhase3", players: ["p1"], abilities: ["discardSelfHand"]))])
    }
    
    func test_ShouldDiscardMultipleExcessCard_IfAnyOnTurnPhase3() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardExcessCardsOnPhase3")
            .attributes(are: [.handLimit: 1])
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"),
                     MockCardProtocol().identified(by: "c3"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "p1")
        let event = GEvent.setPhase(value: 3)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardExcessCardsOnPhase3", actor: "p1")])
        XCTAssertEqual(events, [.addHit(hit: GHit(name: "discardExcessCardsOnPhase3", players: ["p1", "p1"], abilities: ["discardSelfHand"]))])
    }
    
    func test_DoNothing_IfOnPhase3WithoutExcessCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "discardExcessCardsOnPhase3")
            .health(is: 1)
            .attributes(are: [.handLimit: 10])
            .holding(MockCardProtocol().identified(by: "c1"),
                     MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "p1")
        let event = GEvent.setPhase(value: 3)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
