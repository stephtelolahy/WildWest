//
//  DynamiteTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DynamiteTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_DynamiteExplodes_IfFlipCardIsBetween2To9Spades() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "dynamite")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "p1")
            .phase(is: 0)
            .deck(are: MockCardProtocol().withDefault().value(is: "5").suit(is: "♠️"))
        let event = GEvent.setPhase(value: 1)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("dynamite", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .addHit(hit: GHit(name: "dynamite", players: ["p1", "p1", "p1"], abilities: ["looseHealth"])),
                                .discardInPlay(player: "p1", card: "c1")])
    }
    
    func test_PassDynamite_IfFlipCardIsNotBetween2To9Spades() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "dynamite")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
            .phase(is: 0)
            .deck(are: MockCardProtocol().withDefault().value(is: "K").suit(is: "♠️"))
        let event = GEvent.setPhase(value: 1)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("dynamite", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .passInPlay(player: "p1", card: "c1", other: "p2")])
    }
    
    func test_PassDynamite_IfOneOfFlippedCardIsNotSpades() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "dynamite")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
            .attributes(are: [.flippedCards: 2])
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .turn(is: "p1")
            .phase(is: 0)
            .deck(are: MockCardProtocol().withDefault().value(is: "9").suit(is: "♠️"),
                  MockCardProtocol().withDefault().value(is: "4").suit(is: "♥️"))
        let event = GEvent.setPhase(value: 1)
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("dynamite", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .flipDeck,
                                .passInPlay(player: "p1", card: "c1", other: "p2")])
    }
}
