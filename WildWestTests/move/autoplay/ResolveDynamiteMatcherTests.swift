//
//  ResolveDynamiteMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest


class ExplodeDynamiteMatcherTests: XCTestCase {
    
    private let sut = ExplodeDynamiteMatcher()
    
    func test_ShouldExplodeDynamite_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .topDeck(is: MockCardProtocol().value(is: "2").suit(is: .spades))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertEqual(moves, [GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")])
    }
}

class PassDynamiteMatcherTests: XCTestCase {
    
    private let sut = PassDynamiteMatcher()
    
    func test_ShouldPassDynamite_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .topDeck(is: MockCardProtocol().value(is: "2").suit(is: .diamonds))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertEqual(moves, [GameMove(name: .passDynamite, actorId: "p1", cardId: "c1")])
    }
    
}
