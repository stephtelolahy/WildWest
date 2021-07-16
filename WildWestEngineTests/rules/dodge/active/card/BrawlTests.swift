//
//  BrawlTests.swift
//  WildWestEngineTests
//
//  Created by Hugues Stéphano TELOLAHY on 26/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length

import XCTest
import WildWestEngine
import Resolver

class BrawlTests: XCTestCase {
    
    private let sut: GameRulesProtocol = Resolver.resolve()
    
    func test_CanPlayBrawlTodiscardFromAllOthersWithCard() throws {
        // Given
        let mockCard1 = MockCardProtocol()
            .withDefault()
            .identified(by: "c1")
            .abilities(are: "brawl")
            .type(is: .brown)
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
            .holding(mockCard1, MockCardProtocol().withDefault().identified(by: "c2"))
        
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "cX"))
        let mockPlayer3 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p3")
            .playing(MockCardProtocol().identified(by: "cY"))
        let mockPlayer4 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p4")
        
        let mockState = MockStateProtocol()
            .withDefault()
            .turn(is: "p1")
            .phase(is: 2)
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
            .playOrder(is: "p1", "p2", "p3", "p4")
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("brawl", actor: "p1", card: .hand("c1"), args: [.requiredHand: ["c2"]])])
        XCTAssertEqual(events, [.play(player: "p1", card: "c1"),
                                .discardHand(player: "p1", card: "c2"),
                                .addHit(hits: [GHit(player: "p1",
                                                    name: "brawl",
                                                    abilities: ["discardTargetHitHand", "discardTargetHitInPlay"],
                                                    offender: "p1",
                                                    target: "p2"),
                                               GHit(player: "p1",
                                                    name: "brawl",
                                                    abilities: ["discardTargetHitHand", "discardTargetHitInPlay"],
                                                    offender: "p1",
                                                    target: "p3")])])
    }
    
    func test_DiscardTargetHitHand_IfUsingBrawl() throws {
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c2"))
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "discardTargetHitHand")
            .target(is: "p2")
        
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .hits(are: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardTargetHitHand", actor: "p1", args: [.target: ["p2"]])])
        XCTAssertEqual(events, [.discardHand(player: "p2", card: "c2"),
                                .removeHit(player: "p1")])
    }
    
    func test_DiscardTargetHitInPlay_IfUsingBrawl() throws {
        let mockPlayer1 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .withDefault()
            .identified(by: "p2")
            .playing(MockCardProtocol().identified(by: "c2"),
                     MockCardProtocol().identified(by: "c3"))
        let mockHit1 = MockHitProtocol()
            .withDefault()
            .player(is: "p1")
            .abilities(are: "discardTargetHitInPlay")
            .target(is: "p2")
        
        let mockState = MockStateProtocol()
            .withDefault()
            .players(are: mockPlayer1, mockPlayer2)
            .hits(are: mockHit1)
        
        // When
        let moves = sut.active(in: mockState)
        let events = sut.effects(on: try XCTUnwrap(moves?.first), in: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GMove("discardTargetHitInPlay", actor: "p1", args: [.target: ["p2"], .requiredInPlay: ["c2"]]),
                               GMove("discardTargetHitInPlay", actor: "p1", args: [.target: ["p2"], .requiredInPlay: ["c3"]])])
        XCTAssertEqual(events, [.discardInPlay(player: "p2", card: "c2"),
                                .removeHit(player: "p1")])
    }
}
