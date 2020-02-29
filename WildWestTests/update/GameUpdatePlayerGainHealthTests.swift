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
        let sut = GameUpdate.playerGainHealth("p1", 2)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerSetHealth("p1", 2)
        verifyNoMoreInteractions(mockDatabase)
    }
}

