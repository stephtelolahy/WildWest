//
//  GameUpdatePlayerGainHealthTests.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdatePlayerGainHealthTests: XCTestCase {
    
    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_playerSetHealth_IfGainLifePoints() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let sut = GameUpdate.playerGainHealth("p1", 1)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 2)
        verifyNoMoreInteractions(mockDatabase)
    }
}

