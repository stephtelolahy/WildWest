//
//  ResolveJailTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
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
            .challenge(is: Challenge(name: .startTurn))
            .topDeck(is: MockCardProtocol().suit(is: .spades))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .stayInJail, actorId: "p1", cardId: "c1"))
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
            .challenge(is: Challenge(name: .startTurn))
        
        // When
        let moves = sut.autoPlayMove(matching: mockState)
        
        // assert
        XCTAssertNil(moves)
    }
    
    func test_SkipTurn_IfStayInJail() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1").health(is: 1)
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2").health(is: 1)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1, mockPlayer2)
            .currentTurn(is: "p1")
        let move = GameMove(name: .stayInJail, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1"),
                                 .setTurn("p2")])
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
            .challenge(is: Challenge(name: .startTurn))
            .topDeck(is: MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .escapeFromJail, actorId: "p1", cardId: "c1"))
    }
    
    func test_DiscardJail_IfEscapeFromJail() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .escapeFromJail, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerDiscardInPlay("p1", "c1")])
    }
}
