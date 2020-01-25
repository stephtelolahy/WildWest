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
        sut.execute(state: mockState)
        
        // Assert
        verify(mockState, times(2)).pullFromDeck(playerId: "p1")
        verifyNoMoreInteractions(mockState)
    }
}
