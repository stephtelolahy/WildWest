//
//  EquipTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class EquipTests: XCTestCase {
    
    func test_PutCardInPlay_IfArming() {
        // Given
        let mockState = MockMutableGameStateProtocol().withEnabledDefaultImplementation(MutableGameStateProtocolStub())
        let equip = Equip(actorId: "p1", cardId: "c1")
        
        // When
        equip.execute(state: mockState)
        
        // Assert
        verify(mockState).equip(playerId: "p1", cardId: "c1")
        verifyNoMoreInteractions(mockState)
    }
    
    func test_DiscardPreviousGun_IfArmingNewGun() {
        XCTFail()
    }
    
    func test_CardsInFrontOfYouShouldNotShareTheSameName() {
        // cards in front of you should not share the same name
        XCTFail()
    }
}
