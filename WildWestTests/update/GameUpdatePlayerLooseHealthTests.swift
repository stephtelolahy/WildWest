//
//  GameUpdatePlayerLooseHealthTests.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdatePlayerLooseHealthTests: XCTestCase {
    
    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_AddDamageEvent_IfLooseLifePoints() {
        // Given
        let sut = GameUpdate.playerLooseHealth("p1", 0, .byPlayer("p2"))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).playerSetHealth("p1", 0)
        let expectedEvent = DamageEvent(playerId: "p1", source: .byPlayer("p2"))
        verify(mockDatabase).addDamageEvent(equal(to: expectedEvent))
        verifyNoMoreInteractions(mockDatabase)
    }
}

