//
//  ResolveBarrelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class UseBarrelMatcherTests: XCTestCase {
    
    private let sut = UseBarrelMatcher()
    
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
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 1))
            .players(are: mockPlayer1)
        
        // When
        let moves = sut.autoPlayMove(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_ShouldUseBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 0))
            .players(are: mockPlayer1)
            .topDeck(is: MockCardProtocol().suit(is: .hearts))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .useBarrel, actorId: "p1"))
    }
    
    func test_ResolveShootChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 0))
        }
        
        let move = GameMove(name: .useBarrel, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(nil)])
    }
}

class FailBarelMatcherTests: XCTestCase {
    
    private let sut = FailBarelMatcher()
    
    func test_FailBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 0))
            .players(are: mockPlayer1)
            .topDeck(is: MockCardProtocol().suit(is: .clubs))
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .failBarrel, actorId: "p1"))
    }
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 0))
        }
        
        let move = GameMove(name: .failBarrel, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard,
                                 .setChallenge(Challenge(name: .bang, targetIds: ["p1"], barrelsResolved: 1))])
    }
}
