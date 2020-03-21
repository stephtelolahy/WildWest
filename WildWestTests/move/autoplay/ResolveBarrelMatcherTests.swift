//
//  ResolveBarrelMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ResolveBarrelMatcherTests: XCTestCase {
    
    private let sut = ResolveBarrelMatcher()
    
    func test_CanUseBarrel_IfIsTargetOfShootAndPlayingBarrel() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 0)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .barrel)])
    }
    
    func test_CannotResolvedBarrelTwice() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.barrel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .playing(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1"], .bang, "px"))
            .players(are: mockPlayer1)
            .barrelsResolved(is: 1)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
