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
    
    func test_Pull2CardsFromDeck_IfStartingTurn() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = StartTurn(actorId: "p1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).setChallenge(isNil())
        verify(mockState, times(2)).pullDeck(playerId: "p1")
        verify(mockState).setBangsPlayed(0)
        verifyNoMoreInteractions(mockState)
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
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(actions?[0].name, "startTurn")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertNil(actions?[0].cardId)
        XCTAssertEqual(actions?[0].options as? [StartTurn], [StartTurn(actorId: "p1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 start turn")
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
}
