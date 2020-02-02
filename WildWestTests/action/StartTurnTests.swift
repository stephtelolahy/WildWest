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
        verify(mockState, times(2)).pullFromDeck(playerId: "p1")
        verify(mockState).setTurnShoots(0)
        verifyNoMoreInteractions(mockState)
    }
}

class StartTurnRuleTests: XCTestCase {
    
    func test_ShouldStartTurn_IfChallengeIsStartTurn() {
        // Given
        let sut = StartTurnRule()
        let player1 = MockPlayerProtocol().identified(by: "p1")
        let player2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: 1)
            .players(are: player1, player2)
            .challenge(is: .startTurn)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [StartTurn], [StartTurn(actorId: "p2")])
    }
}
