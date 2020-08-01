//
//  ResolveDynamiteTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveDynamiteMatcherTests: XCTestCase {
    
    private let sut = ResolveDynamiteMatcher()
    
    func test_ShouldExplodeDynamite_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .deckCards(are: MockCardProtocol().value(is: "2").suit(is: .spades))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1"))
    }
    
    func test_Deal3Damages_IfDynamiteExplodes_OnHealthIs4() {
        // Given
        let mockState = MockGameStateProtocol()
            .allPlayers(are: MockPlayerProtocol().identified(by: "p1").health(is: 4).withDefault())
        let move = GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerSetDamage("p1", DamageEvent(damage: 3, source: .byDynamite)),
                                 .playerSetHealth("p1", 1),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_Deal2Damages_IfDynamiteExplodes_OnHealthIs3() {
        // Given
        let mockState = MockGameStateProtocol()
            .allPlayers(are: MockPlayerProtocol().identified(by: "p1").health(is: 3).withDefault())
        let move = GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerSetDamage("p1", DamageEvent(damage: 2, source: .byDynamite)),
                                 .playerSetHealth("p1", 1),
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 1)),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_Deal1Damages_IfDynamiteExplodes_OnHealthIs2() {
        // Given
        let mockState = MockGameStateProtocol()
            .allPlayers(are: MockPlayerProtocol().identified(by: "p1").health(is: 2).withDefault())
        let move = GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byDynamite)),
                                 .playerSetHealth("p1", 1),
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 2)),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_DoNotDealDamage_IfDynamiteExplodes_OnHealthIs1() {
        // Given
        let mockState = MockGameStateProtocol()
            .allPlayers(are: MockPlayerProtocol().identified(by: "p1").health(is: 1).withDefault())
        let move = GameMove(name: .dynamiteExploded, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(Challenge(name: .dynamiteExploded, damage: 3)),
                                 .playerDiscardInPlay("p1", "c1")])
    }
    
    func test_ShouldPassDynamite_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite).identified(by: "c1"))
            .withDefault()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .deckCards(are: MockCardProtocol().value(is: "2").suit(is: .diamonds))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // assert
        XCTAssertEqual(move, GameMove(name: .passDynamite, actorId: "p1", cardId: "c1"))
    }
    
    func test_PassDynamiteToNextPlayer_IfDoesNotExplode() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1").withDefault()
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .passDynamite, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .playerPassInPlayOfOther("p1", "p2", "c1")])
    }    
}
