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
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 1)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
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
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 0)
            .topDeck(is: MockCardProtocol().suit(is: .hearts))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .useBarrel, actorId: "p1")])
    }
    
    func test_ResolveShootChallenge_IfReturnHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
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
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 0)
            .topDeck(is: MockCardProtocol().suit(is: .clubs))
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .failBarrel, actorId: "p1")])
    }
    
    func test_DoNotResolveShootChallenge_IfReturnNonHeartFromDeck() {
        // Given
        let mockState = MockGameStateProtocol()
        Cuckoo.stub(mockState) { mock in
            when(mock.challenge.get).thenReturn(.shoot(["p1"], .bang, "px"))
            when(mock.barrelsResolved.get).thenReturn(0)
        }
        
        let move = GameMove(name: .failBarrel, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.flipOverFirstDeckCard])
    }
}

