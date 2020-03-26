//
//  ResolveJailMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 26/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StayInJailMatcherTests: XCTestCase {

    private let sut = StayInJailMatcher()

    func test_ShouldStayInJail_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .topDeck(is: MockCardProtocol().suit(is: .spades))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertEqual(moves, [GameMove(name: .stayInJail, actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotResolveJail_IfPlayingDynamite() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"),
                     MockCardProtocol().named(.jail).identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertNil(moves)
    }
}

class EscapeFromJailMatcherTests: XCTestCase {

    private let sut = EscapeFromJailMatcher()

    func test_ShouldEscapeFromJail_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .topDeck(is: MockCardProtocol().suit(is: .hearts))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertEqual(moves, [GameMove(name: .escapeFromJail, actorId: "p1", cardId: "c1")])
    }
}
