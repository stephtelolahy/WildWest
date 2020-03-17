//
//  StartTurnMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/16/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StartTurnMatcherTests: XCTestCase {
    
    private let sut = StartTurnMatcher()
    
    func test_ShouldStartTurn_IfChallengeIsStartTurn() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .players(are: player1)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        let expectedMove = GameMove(name: .startTurn, actorId: "p1")
        XCTAssertEqual(moves, [expectedMove])
    }
    
    func test_CannotStartTurn_IfPlayingJail() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .playing(MockCardProtocol().named(.jail))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .players(are: player1)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotStartTurn_IfPlayingDynamite() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 1)
            .playing(MockCardProtocol().named(.dynamite))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .players(are: player1)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotStartTurn_IfHealth_IsZero() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: .startTurn)
            .players(are: player1)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
}
