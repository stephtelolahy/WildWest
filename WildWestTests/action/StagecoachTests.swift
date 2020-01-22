//
//  StagecoachTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Stagecoach
/// “Draw two cards” from the top of the deck.
///
class StagecoachTests: XCTestCase {
    
    func test_Pull2Cards_IfPlayingStagecoach() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let stagecoach = Stagecoach(actorId: "p1", cardId: "c1")
        
        // When
        stagecoach.execute(state: mockState)
        
        // Assert
        verify(mockState).discard(playerId: "p1", cardId: "c1")
        verify(mockState, times(2)).pull(playerId: "p1")
        verifyNoMoreInteractions(mockState)
    }
}
