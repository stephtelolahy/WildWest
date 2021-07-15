//
//  PanicTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 04/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class PanicTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    // MARK: - Draw random hand
    
    func test_CanPlayPanicToDramFromOtherHand() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "drawOtherHandAt1")
            .type(is: .brown)
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
            .attributes(are: [.mustang: 1])
            .holding(MockCardProtocol().identified(by: "c3"))
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
        XCTAssertEqual(moves, [GMove("drawOtherHandAt1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .drawHand(player: "p1", other: "p2", card: "c2")])
    }
    
    // MARK: - Draw inPlay
    
    func test_CanPlayPanicToDrawOtherInPlay() throws {
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "drawOtherInPlayAt1")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .attributes(are: [.scope: 1])
            .holding(mockCard1)
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().withDefault().identified(by: "c2"))
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
            .attributes(are: [.mustang: 3])
            .playing(MockCardProtocol().withDefault().identified(by: "c3"))
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .playOrder(is: "p1", "p2", "p3")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawOtherInPlayAt1", actor: "p1", card: .hand("c1"), args: [.target: ["p2"], .requiredInPlay: ["c2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .drawInPlay(player: "p1", other: "p2", card: "c2")])
    }
}
