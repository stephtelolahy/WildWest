//
//  GameUpdateEliminatePlayerTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GameUpdateEliminatePlayerTests: XCTestCase {

    private let mockDatabase = MockGameDatabaseProtocol().withEnabledDefaultImplementation(GameDatabaseProtocolStub())
    
    func test_RemoveFromActivePlayers_IfEliminating() {
        // Given
        let mockPlayer = MockPlayerProtocol()
        Cuckoo.stub(mockDatabase) { mock in
            when(mock.removePlayer("p1")).thenReturn(mockPlayer)
        }
        let sut = GameUpdate.eliminatePlayer("p1")
        
        // When
        sut.execute(in: mockDatabase)
        
        // Assert
        verify(mockDatabase).removePlayer("p1")
        verify(mockDatabase).addEliminated(player(equalTo: mockPlayer))
    }
}
