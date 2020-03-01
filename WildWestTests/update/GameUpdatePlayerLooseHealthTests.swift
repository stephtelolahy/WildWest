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
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 3))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let sut = GameUpdate.playerLooseHealth("p1", 1, .byPlayer("p2"))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 2)
        let expectedEvent = DamageEvent(playerId: "p1", source: .byPlayer("p2"))
        verify(mockDatabase).addDamageEvent(equal(to: expectedEvent))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetZeroHealth_IfLooseMoreThanCurrentLifePoints() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").health(is: 1))
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let sut = GameUpdate.playerLooseHealth("p1", 3, .byDynamite)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).state.get()
        verify(mockDatabase).playerSetHealth("p1", 0)
        let expectedEvent = DamageEvent(playerId: "p1", source: .byDynamite)
        verify(mockDatabase).addDamageEvent(equal(to: expectedEvent))
        verifyNoMoreInteractions(mockDatabase)
    }
    
}

