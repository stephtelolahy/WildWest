//
//  GameUpdateSetTurnTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateSetTurnTests: XCTestCase {
    
    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_SetTurn_IfSettingTurn() {
        // Given
        let sut = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setTurn("p1")
    }
    
    func test_ResetBangsPlayed_IfSettingTurn() {
        // Given
        let sut = GameUpdate.setTurn("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).setBangsPlayed(0)
    }   
}
