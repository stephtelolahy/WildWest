//
//  BarrelTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 06/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Resolver

class BarrelTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CancelShoot_IfFlipCardIsHearts() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "barrel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
            .flippedCards(is: 1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .deck(are: MockCardProtocol().withDefault().value(is: "7").suit(is: "♥️"))
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck,
                                .removeHit(player: "p1")])
    }
    
    func test_DoNothing_IfFlipCardIsSpades() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "barrel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .playing(mockCard1)
            .flippedCards(is: 1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .deck(are: MockCardProtocol().withDefault().value(is: "A").suit(is: "♠️"))
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1", card: .inPlay("c1"))])
        XCTAssertEqual(events, [.flipDeck])
    }
    
    func test_ResolveBarrelTwice_IfHavingAbility_AndInPlayCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "barrel")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "barrel")
            .flippedCards(is: 1)
            .playing(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1"),
                               GMove("barrel", actor: "p1", card: .inPlay("c1"))])
    }
    
    func test_FlipTwoCards_IfHavingAbility() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "barrel")
            .flippedCards(is: 2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .hits(are: mockHit1)
            .deck(are: MockCardProtocol().withDefault().value(is: "4").suit(is: "♣️"),
                  MockCardProtocol().withDefault().value(is: "9").suit(is: "♠️"))
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1")])
        XCTAssertEqual(events, [.flipDeck,
                                .flipDeck])
    }
    
    func test_CancelShoot_IfFirstFlipCardIsHeart() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "barrel")
            .flippedCards(is: 2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .hits(are: mockHit1)
            .deck(are: MockCardProtocol().withDefault().value(is: "10").suit(is: "♥️"),
                  MockCardProtocol().withDefault().value(is: "Q").suit(is: "♠️"))
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1")])
        XCTAssertEqual(events, [.flipDeck,
                                .flipDeck,
                                .removeHit(player: "p1")])
    }
    
    func test_CancelShoot_IfSeconfFlipCardIsHeart() throws {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .abilities(are: "barrel")
            .flippedCards(is: 2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .playOrder(is: "p1")
            .hits(are: mockHit1)
            .deck(are: MockCardProtocol().withDefault().value(is: "6").suit(is: "♣️"),
                  MockCardProtocol().withDefault().value(is: "K").suit(is: "♥️"))
        let event = GEvent.addHit(hits: [GHit(player: "p1", name: "n1", abilities: [], offender: "", cancelable: 1)])
        
        // When
        let moves = sut.triggered(on: event, in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("barrel", actor: "p1")])
        XCTAssertEqual(events, [.flipDeck,
                                .flipDeck,
                                .removeHit(player: "p1")])
    }
}
