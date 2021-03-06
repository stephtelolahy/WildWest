//
//  StartTurnTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StartTurnTests: XCTestCase {
    
    private let sut = StartTurnMatcher()
    
    func test_ShouldStartTurn_IfChallengeIsStartTurn() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .withDefault()
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
        
        // When
        let move = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .startTurn, actorId: "p1"))
    }
    
    func test_CannotStartTurn_IfPlayingJail() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
        
        // When
        let moves = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotStartTurn_IfPlayingDynamite() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
        
        // When
        let moves = sut.autoPlay(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_Pull2CardsFromDeck_IfStartingTurn() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").withDefault())
        let move = GameMove(name: .startTurn, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1")])
    }
}
