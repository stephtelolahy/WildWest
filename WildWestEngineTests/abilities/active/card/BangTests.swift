//
//  BangTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
// swiftlint:disable type_body_length

import XCTest
import WildWestEngine
import Resolver

class BangTests: XCTestCase {
    
    private let sut: AbilityMatcherProtocol = Resolver.resolve()
    
    func test_CanPlayBang_IfOtherIsReachable() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "bang")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 1)
            .bangsPerTurn(is: 1)
            .bangsCancelable(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
            .playOrder(is: "p1", "p2", "p3")
            .distance(from: "p1", to: "p2", is: 1)
            .distance(from: "p1", to: "p3", is: 3)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("bang", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(player: "p2", name: "bang", abilities: ["looseHealth"], cancelable: 1, offender: "p1")])
    }
    
    func test_CannotPlayBang_IfReachedLimitPerTurn() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "bang")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 1)
            .bangsPerTurn(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .distance(from: "p1", to: "p2", is: 1)
            .played(are: "bang")
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotPlayBang_IfOtherIsUnreachable() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "bang")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 1)
            .bangsPerTurn(is: 1)
            .bangsCancelable(is: 1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .distance(from: "p1", to: "p2", is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_Need2MissesToCancelHisBang_IfPlayingBangAndHAvingAbility() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "bang")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .weapon(is: 2)
            .bangsPerTurn(is: 1)
            .bangsCancelable(is: 2)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
            .distance(from: "p1", to: "p2", is: 2)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("bang", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .addHit(player: "p2", name: "bang", abilities: ["looseHealth"], cancelable: 2, offender: "p1")])
    }
}
