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
            .challenge(is: Challenge(name: .startTurn))
            .topDeck(is: MockCardProtocol().value(is: "2").suit(is: .spades))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1"))
    }
    
    func test_Deal3Damages_IfDynamiteExplodes_OnHealthIs4() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 4))
        let move = GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerLooseHealth("p1", 3, .byDynamite),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_Deal2Damages_IfDynamiteExplodes_OnHealthIs3() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 3))
        let move = GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerLooseHealth("p1", 2, .byDynamite),
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 1)),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_Deal1Damages_IfDynamiteExplodes_OnHealthIs2() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 2))
        let move = GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerLooseHealth("p1", 1, .byDynamite),
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 2)),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_DoNotDealDamage_IfDynamiteExplodes_OnHealthIs1() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1))
        let move = GameMove(name: .explodeDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 3)),
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
            .challenge(is: Challenge(name: .startTurn))
            .topDeck(is: MockCardProtocol().value(is: "2").suit(is: .diamonds))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .passDynamite, actorId: "p1", cardId: "c1"))
    }
    
    func test_PassDynamiteToNextPlayer_IfDoesNotExplode() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1").health(is: 1)
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2").health(is: 1)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .passDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerPassInPlayOfOther("p1", "p2", "c1")])
    }    
}
