//
//  DiscardBeerTests.swift
//  CardGameEngine_Tests
//
//  Created by Hugues Stephano Telolahy on 17/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import WildWestEngine
import Resolver

class DiscardBeerTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanDiscardBeer_IfIsTargetOfShootAndWillBeEliminated() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .type(is: .brown)
            .abilities(are: "discardBeer")
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1)
            .health(is: 1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "looseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2", "p3")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardBeer", actor: "p1", card: .hand("c1")),
                               GMove("looseHealth", actor: "p1")])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .removeHit(player: "p1")])
    }
    
    func test_CannotDiscardBeer_IfNotLastHealth() throws {
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(MockCardProtocol().withDefault().identified(by: "c1").abilities(are: "discardBeer"))
            .health(is: 2)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "looseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2", "p3")
        let discardBeer = GMove("discardBeer", actor: "p1", args: [.requiredHand: ["c1"]])
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        let unwrappedMoves = try XCTUnwrap(moves)
        XCTAssertFalse(unwrappedMoves.contains(discardBeer))
    }
    
    func test_CannotDiscardBeer_IfThereAreTwoPlayersLeft() throws {
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(MockCardProtocol().withDefault().identified(by: "c1").abilities(are: "discardBeer"))
            .health(is: 1)
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "looseHealth")
        let mockState = MockStateProtocol()
            .withDefault()
            .hits(are: mockHit1)
            .players(are: mockPlayer1)
            .playOrder(is: "p1", "p2")
        let discardBeer = GMove("discardBeer", actor: "p1", args: [.requiredHand: ["c1"]])
        
        // When
        let moves = sut.active(in: mockState)
        
        // Assert
        let unwrappedMoves = try XCTUnwrap(moves)
        XCTAssertFalse(unwrappedMoves.contains(discardBeer))
    }
}
