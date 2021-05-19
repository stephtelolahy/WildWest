//
//  CatBalouTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Resolver

class CatBalouTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    // MARK: - Discard random hand
    
    func test_CanPlayCatBalouToDiscardOtherHand() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "discardOtherHand")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
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
        XCTAssertEqual(moves, [GMove("discardOtherHand", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p2", card: "c2")])
    }
    
    func test_CannotPlayCatBalouToDiscardSelfHand() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "discardOtherHand")
        let mockCard2 = MockCardProtocol()
            .withDefault()
            .identified(by: "c2")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
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
    
    // MARK: - Discard inPlay
    
    func test_CanPlayCatBalouToDiscardOtherInPlay() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "discardOtherInPlay")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().identified(by: "c2"))
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
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
        XCTAssertEqual(moves, [GMove("discardOtherInPlay", actor: "p1", card: .hand("c1"), args: [.target: ["p2"], .requiredInPlay: ["c2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardInPlay(player: "p2", card: "c2")])
    }
    
    func test_CanPlayCatBalouToDiscardSelfInPlay() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "discardSelfInPlay")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardSelfInPlay", actor: "p1", card: .hand("c1"), args: [.target: ["p1"], .requiredInPlay: ["c2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardInPlay(player: "p1", card: "c2")])
    }
    
    func test_CannotPlayCatBalou_IfNoSelfInPlayCard() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "discardSelfInPlay")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
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
