//
//  StartTurnTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class StartTurnTests: XCTestCase {
    
    func test_StartTurnDescription() {
        // Given
        let sut = StartTurn(actorId: "p1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 starts turn")
    }
    
    func test_Pull2CardsFromDeck_IfStartingTurn() {
        // Given
        let sut = StartTurn(actorId: "p1")
        
        // When
        let updates = sut.execute(in: MockGameStateProtocol())
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .setChallenge(nil),
            .setBangsPlayed(0),
            .playerPullFromDeck("p1"),
            .playerPullFromDeck("p1")
        ])
    }
}

class StartTurnRuleTests: XCTestCase {
    
    func test_ShouldStartTurn_IfChallengeIsStartTurn() {
        // Given
        let sut = StartTurnRule()
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: player1)
            .challenge(is: .startTurn)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [StartTurn], [StartTurn(actorId: "p1")])
    }
    
    func test_CannotStartTurn_IfPlayingJail() {
        // Given
        let sut = StartTurnRule()
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.jail))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: player1, MockPlayerProtocol())
            .challenge(is: .startTurn)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CannotStartTurn_IfPlayingDynamite() {
        // Given
        let sut = StartTurnRule()
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .playing(MockCardProtocol().named(.dynamite))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: player1, MockPlayerProtocol())
            .challenge(is: .startTurn)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
