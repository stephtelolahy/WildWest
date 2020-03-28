//
//  ResolveDynamiteTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

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
        XCTAssertEqual(moves, [GameMove(name: MoveName("explodeDynamite"), actorId: "p1", cardId: "c1")])
    }
    
    func test_DiscardDynamiteAndSetExplodeChallenge_IfExplodes() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: MoveName("explodeDynamite"), actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(.dynamiteExploded),
                                 .playerDiscardInPlay("p1", "c1")])
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
        XCTAssertEqual(moves, [GameMove(name: MoveName("passDynamite"), actorId: "p1", cardId: "c1")])
    }
    
    func test_PassDynamiteToNextPlayer_IfDoesNotExplode() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.turn.get).thenReturn("p1")
            when(mock.players.get).thenReturn([
                MockPlayerProtocol().identified(by: "p1"),
                MockPlayerProtocol().identified(by: "p2")
            ])
        }
        let move = GameMove(name: MoveName("passDynamite"), actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerPassInPlayOfOther("p1", "p2", "c1")])
    }    
}
