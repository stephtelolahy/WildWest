//
//  RagTimeTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 25/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class RagTimeTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayRagTimeToDrawFromOtherHand() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "drawOtherHandRequire1Card")
            .type(is: .brown)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, MockCardProtocol().withDefault().identified(by: "c3"))
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawOtherHandRequire1Card", actor: "p1", card: .hand("c1"), args: [.target: ["p2"], .requiredHand: ["c3"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c3"),
                                .drawHand(player: "p1", other: "p2", card: "c2")])
    }
    
    // MARK: - Draw inPlay
    
    func test_CanPlayRagTimeToDrawOtherInPlay() throws {
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "drawOtherInPlayRequire1Card")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, MockCardProtocol().withDefault().identified(by: "c3"))
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().identified(by: "c2"))
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2)
            .playOrder(is: "p1", "p2")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("drawOtherInPlayRequire1Card",
                                     actor: "p1",
                                     card: .hand("c1"),
                                     args: [.target: ["p2"], .requiredInPlay: ["c2"], .requiredHand: ["c3"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c3"),
                                .drawInPlay(player: "p1", other: "p2", card: "c2")])
    }
    
}
