//
//  SaloonTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Saloon
/// Cards with symbols on two lines have two simultaneous effects, one for each line.
/// Here symbols say: “Regain one life point”, and this applies to “All the other players”,
/// and on the next line: “[You] regain one life point”.
/// The overall effect is that all players in play regain one life point.
/// You cannot play a Saloon out of turn when you are losing
/// your last life point: the Saloon is not a Beer!
///
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
