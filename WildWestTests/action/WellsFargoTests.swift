//
//  WellsFargoTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// WellsFargo
/// “Draw three cards” from the top of the deck.
///
class WellsFargoTests: XCTestCase {
    
    func test_Pull3Cards_IfPlayingWellsFargo() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let wellsFargo = WellsFargo(actorId: "p1", cardId: "c1")
        
        // When
        wellsFargo.execute(state: mockState)
        
        // Assert
        verify(mockState).discard(playerId: "p1", cardId: "c1")
        verify(mockState, times(3)).pull(playerId: "p1")
        verifyNoMoreInteractions(mockState)
    }
}
