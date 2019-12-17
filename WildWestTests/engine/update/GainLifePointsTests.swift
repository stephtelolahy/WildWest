//
//  GainLifePointsTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GainLifePointsTests: XCTestCase {
    
    func test_GainOneLifePoint() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockPlayer = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub())
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.identifier.get).thenReturn("p1")
            when(mock.health.get).thenReturn(3)
        }
        
        // When
        let update = GainLifePoints(player: mockPlayer, points: 1)
        update.apply(to: mockState)
        
        // Assert
        verify(mockPlayer).setHealth(4)
        verify(mockState).addMessage("p1 gain 1 life points")
    }
    
    func test_GainTwoLifePoints() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let mockPlayer = MockPlayerProtocol().withEnabledDefaultImplementation(PlayerProtocolStub())
        Cuckoo.stub(mockPlayer) { mock in
            when(mock.identifier.get).thenReturn("p1")
            when(mock.health.get).thenReturn(1)
        }
        
        // When
        let update = GainLifePoints(player: mockPlayer, points: 2)
        update.apply(to: mockState)
        
        // Assert
        verify(mockPlayer).setHealth(3)
        verify(mockState).addMessage("p1 gain 2 life points")
    }
    
}
