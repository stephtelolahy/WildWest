//
//  SaloonTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class SaloonTests: XCTestCase {
    
    func test_EachPlayerGainLifePoint_IfPlayingSaloon() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let saloon = Saloon(actorId: "p1", cardId: "c1", otherPlayerIds: ["p2", "p3"])
        
        // When
        saloon.execute(state: mockState)
        
        // Assert
        verify(mockState).discard(playerId: "p1", cardId: "c1")
        verify(mockState).gainLifePoint(playerId: "p1")
        verify(mockState).gainLifePoint(playerId: "p2")
        verify(mockState).gainLifePoint(playerId: "p3")
    }
}
