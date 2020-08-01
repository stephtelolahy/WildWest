//
//  ResolveBarrelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class ResolveBarrelMatcherTests: XCTestCase {
    
    private let sut = ResolveBarrelMatcher()
    
    func test_CannotResolvedBarrelTwice() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 1))
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_SuccessFulBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: mockPlayer1)
            .deckCards(are: MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .useBarrel, actorId: "p1"))
    }
    
    func test_RemoveBangChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: MockPlayerProtocol().identified(by: "p1").withDefault())
        
        let move = GameMove(name: .useBarrel, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .flipOverFirstDeckCard])
    }
    
    func test_RemoveGatlingChallengeAndResetBarrelsPlayed_UsingBarrel() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2"], barrelsPlayed: 1))
            .players(are: MockPlayerProtocol().identified(by: "p1").withDefault())
        
        let move = GameMove(name: .useBarrel, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .gatling, targetIds: ["p2"], barrelsPlayed: 0)),
                                 .flipOverFirstDeckCard])
    }
    
    func test_FailBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: mockPlayer1)
            .deckCards(are: MockCardProtocol().suit(is: .clubs))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .failBarrel, actorId: "p1"))
    }
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: MockPlayerProtocol().identified(by: "p1").withDefault())
        
        let move = GameMove(name: .failBarrel, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 1)),
                                 .flipOverFirstDeckCard])
    }
    
    func test_SuccessFulBarrel_IfOneCardMakeItWorks_AndHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.flips2CardsOnADrawAndChoose1: true])
            .playing(MockCardProtocol().named(.barrel))
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: mockPlayer1)
            .deckCards(are: MockCardProtocol().suit(is: .spades), MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .useBarrel, actorId: "p1"))
    }
    
    func test_FlipTwoCardsForBarrel_AndHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.flips2CardsOnADrawAndChoose1: true])
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsPlayed: 0))
            .players(are: mockPlayer1)
        
        let move = GameMove(name: .useBarrel, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .flipOverFirstDeckCard,
                                 .flipOverFirstDeckCard])
    }
    
    func test_SuccessfulFirstBarrel_IfMissedRequiredIsTwo_AndHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.hasBarrelAllTimes: true])
            .playing(MockCardProtocol().named(.barrel))
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], counterNeeded: 2, barrelsPlayed: 0))
            .players(are: mockPlayer1)
            .deckCards(are: MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        let updates = sut.updates(onExecuting: move!, in: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .useBarrel, actorId: "p1"))
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .bang, targetIds: ["p1"], counterNeeded: 1, barrelsPlayed: 1)),
                                 .flipOverFirstDeckCard])
        
    }
    
    func test_SuccessfulSecondBarrel_IfMissedRequiredIsTwo_AndHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .abilities(are: [.hasBarrelAllTimes: true])
            .playing(MockCardProtocol().named(.barrel))
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], counterNeeded: 1, barrelsPlayed: 1))
            .players(are: mockPlayer1)
            .deckCards(are: MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlay(matching: mockState)
        let updates = sut.updates(onExecuting: move!, in: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .useBarrel, actorId: "p1"))
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .flipOverFirstDeckCard])
        
    }
}

