//
//  GameUpdateSetChallengeTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateSetChallengeTests: XCTestCase {
    
    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_RemoveChallenge_IfSettingNilChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(nil)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(isNil())
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_SetChallenge_IfSettingChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(.startTurn)
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setChallenge(equal(to: .startTurn))
        verifyNoMoreInteractions(mockDatabase)
    }
    
    func test_IncrementBangsPlayed_IfSettingBangChallenge() {
        // Given
        let mockState = MockGameStateProtocol().bangsPlayed(is: 0)
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.state.get).thenReturn(mockState)
        }
        let sut = GameUpdate.setChallenge(.shoot(["p1"], .bang))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBangsPlayed(1)
    }
    
    func test_ResetBarrelsResolved_IfSettingShootChallenge() {
        // Given
        let sut = GameUpdate.setChallenge(.shoot(["p1"], .gatling))
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBarrelsResolved(0)
    }
}
