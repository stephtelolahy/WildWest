//
//  AbilityMatcherTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 03/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class AbilityMatcherTests: XCTestCase {

    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_TriggerSpecialAbilityBeforeDefaultAbilities() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"))
            .playing(MockCardProtocol().withDefault().identified(by: "c2"))
            .abilities(are: "discardAllCardsOnEliminated", "nextTurnOnEliminated")
        
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .abilities(are: "drawsAllCardsFromEliminatedPlayer")
            
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p2")
            .initialOrder(is: "p1", "p2")
            .turn(is: "p1")
        
        let event = GEvent.eliminate(player: "p1", offender: "pX")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawsAllCardsFromEliminatedPlayer", actor: "p2", args: [.target: ["p1"]]),
                               GMove("discardAllCardsOnEliminated", actor: "p1"),
                               GMove("nextTurnOnEliminated", actor: "p1")])
    }
    
    func test_TriggerDynamiteBeforeJail() {
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(MockCardProtocol().withDefault().identified(by: "c1").abilities(are: "jail"),
                     MockCardProtocol().withDefault().identified(by: "c2").abilities(are: "dynamite"))
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
        let event = GEvent.setPhase(value: 1)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("dynamite", actor: "p1", card: .inPlay("c2")),
                               GMove("jail", actor: "p1", card: .inPlay("c1"))])
    }
}
