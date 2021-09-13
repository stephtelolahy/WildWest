//
//  MissedTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class MissedTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayMissed_IfHitByBang() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "missed")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hit(is: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("missed", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .removeHit(player: "p1")])
    }
    
    func test_CanPlayMissed_ToDecrementCancelable() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "missed")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p1")
            .cancelable(is: 2)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1)
            .hit(is: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("missed", actor: "p1", card: .hand("c1"))])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .decrementHitCancelable])
    }
    
    func test_CannotPlayMissed_IfNotFirsToResolveHit() {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "missed")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .players(are: "p2", "p1")
            .cancelable(is: 1)
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .hit(is: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
