//
//  PenalizeSheriffOnEliminatingDeputyTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 11/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PenalizeSheriffOnEliminatingDeputyTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_SheriffDiscardAllHand_OnEliminatingDeputy() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(MockCardProtocol().withDefault().identified(by: "c1"),
                     MockCardProtocol().withDefault().identified(by: "c2"))
            .abilities(are: "penalizeOnEliminatingDeputy")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .role(is: .deputy)
        let mockState = MockStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "p1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("penalizeOnEliminatingDeputy", actor: "p1")])
        XCTAssertEqual(events, [.discardHand(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2")])
    }
    
    func test_SheriffDiscardAllInPlay_OnEliminatingDeputy() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .role(is: .sheriff)
            .playing(MockCardProtocol().withDefault().identified(by: "c3"),
                     MockCardProtocol().withDefault().identified(by: "c4"))
            .abilities(are: "penalizeOnEliminatingDeputy")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .role(is: .deputy)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1")
        let event = GEvent.eliminate(player: "p2", offender: "p1")
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("penalizeOnEliminatingDeputy", actor: "p1")])
        XCTAssertEqual(events, [.discardInPlay(player: "p1", card: "c3"),
                                .discardInPlay(player: "p1", card: "c4")])
    }
}
