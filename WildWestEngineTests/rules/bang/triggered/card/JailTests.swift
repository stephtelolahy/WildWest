//
//  JailTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 09/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class JailTests: XCTestCase {

    private let sut: GameRulesProtocol = Resolver.resolve()

    func test_EscapeFromJail_IfFlipCardIsHearts() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "jail")
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
            .deck(are: MockCardProtocol().withDefault().value(is: "7").suit(is: "♥️"))
        let event = GEvent.setPhase(value: 1)

        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)

        // Assert
        XCTAssertEqual(moves, [GMove("jail", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .discardInPlay(player: "p1", card: "c1")])
    }

    func test_StayInJail_IfFlipCardIsNotHearts() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "jail")
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
            .deck(are: MockCardProtocol().withDefault().value(is: "9").suit(is: "♦️"))
        let event = GEvent.setPhase(value: 1)

        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)

        // Assert
        XCTAssertEqual(moves, [GMove("jail", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .setTurn(player: "p2"),
                                .setPhase(value: 1),
                                .discardInPlay(player: "p1", card: "c1")])
    }

    func test_EscapeFromJail_IfOneOfFlippedCardIsHearts() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "jail")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
            .attributes(are: [.flippedCards: 2])
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .turn(is: "p1")
            .phase(is: 0)
            .deck(are: MockCardProtocol().withDefault().value(is: "4").suit(is: "♣️"),
                  MockCardProtocol().withDefault().value(is: "J").suit(is: "♥️"))
        let event = GEvent.setPhase(value: 1)

        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)

        // Assert
        XCTAssertEqual(moves, [GMove("jail", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .flipDeck,
                                .discardInPlay(player: "p1", card: "c1")])
    }
}
