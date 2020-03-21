//
//  ResolveJailMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class ResolveJailMatcherTests: XCTestCase {
    
    private let sut = ResolveJailMatcher()
    
    func test_ShouldResolveJail_BeforeStartingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail).identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // assert
        XCTAssertEqual(moves, [GameMove(name: .resolve, actorId: "p1", cardId: "c1", cardName: .jail)])
    }
    
    func test_ShouldResolveDynamite_BeforeResolvingJail() {
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
