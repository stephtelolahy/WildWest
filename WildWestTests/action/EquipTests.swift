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
    
    func test_PutCardInPlay_IfEquipping() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer)
        let sut = Equip(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).players.get()
        verify(mockState).putInPlay(playerId: "p1", cardId: "c1")
        verifyNoMoreInteractions(mockState)
    }
    
    func test_DiscardPreviousGun_IfArmingNewGun() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .playing(MockCardProtocol().identified(by: "c2").named(.volcanic))
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer)
        let sut = Equip(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).players.get()
        verify(mockState).putInPlay(playerId: "p1", cardId: "c1")
        verify(mockState).discardInPlay(playerId: "p1", cardId: "c2")
        verifyNoMoreInteractions(mockState)
    }
}

class EquipRuleTests: XCTestCase {
    
    func test_CanEquip_IfYourTurnAndOwnCard() {
        // Given
        let sut = EquipRule()
        let mockCard1 = MockCardProtocol()
            .named(.schofield)
            .identified(by: "c1")
        let mockCard2 = MockCardProtocol()
            .named(.scope)
            .identified(by: "c2")
        let mockCard3 = MockCardProtocol()
            .named(.dynamite)
            .identified(by: "c3")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2, mockCard3)
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions?.count, 3)
        
        XCTAssertEqual(actions?[0].name, "schofield")
        XCTAssertEqual(actions?[0].actorId, "p1")
        XCTAssertEqual(actions?[0].cardId, "c1")
        XCTAssertEqual(actions?[0].options as? [Equip], [Equip(actorId: "p1", cardId: "c1")])
        XCTAssertEqual(actions?[0].options[0].description, "p1 plays c1")
        
        XCTAssertEqual(actions?[1].name, "scope")
        XCTAssertEqual(actions?[1].actorId, "p1")
        XCTAssertEqual(actions?[1].cardId, "c2")
        XCTAssertEqual(actions?[1].options as? [Equip], [Equip(actorId: "p1", cardId: "c2")])
        XCTAssertEqual(actions?[1].options[0].description, "p1 plays c2")
        
        XCTAssertEqual(actions?[2].name, "dynamite")
        XCTAssertEqual(actions?[2].actorId, "p1")
        XCTAssertEqual(actions?[2].cardId, "c3")
        XCTAssertEqual(actions?[2].options as? [Equip], [Equip(actorId: "p1", cardId: "c3")])
        XCTAssertEqual(actions?[2].options[0].description, "p1 plays c3")
    }
    
    func test_CannotEquip_IfAlreadyPlayingCardWithTheSameName() {
        // Given
        let sut = EquipRule()
        let mockCard1 = MockCardProtocol()
            .named(.mustang)
        let mockCard2 = MockCardProtocol()
            .named(.mustang)
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard1)
            .playing(mockCard2)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CannotEquipJail() {
        // Given
        let sut = EquipRule()
        let mockCard = MockCardProtocol()
            .named(.jail)
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
