//
//  EquipTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/// Blue-bordered cards
/// are played face up in front of you (exception: Jail).
/// Blue cards in front of you are hence defined to be “in play”.
/// The effect of these cards lasts until they are discarded or
/// removed somehow (e.g. through the play of a CatBalou),
/// or a special event occurs (e.g. in the case of Dynamite).
/// There is no limit on the cards you can have in front of you
/// provided that they do not share the same name.
///
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
