//
//  EndTurnMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EndTurnMatcherTests: XCTestCase {
    
    private let sut = EndTurnMatcher()
    
    func test_CanEndTurnWithoutDicardingExcessCards_IfPlayingNoChallenge() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 3)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .endTurn, actorId: "p1")])
    }
    
    func test_CanEndTurnWithDicardingOneExcessCard_IfPlayingNoChallenge() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 2)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c1"]),
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c2"]),
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c3"])
        ])
    }
    
    func test_CanEndTurnWithDicardingAllCombinationsOfExcessCards_IfPlayingNoChallenge() {
        // Given
        let card1 = MockCardProtocol().identified(by: "c1")
        let card2 = MockCardProtocol().identified(by: "c2")
        let card3 = MockCardProtocol().identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .holding(card1, card2, card3)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c1", "c2"]),
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c1", "c3"]),
            GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c2", "c3"])
        ])
    }
}
