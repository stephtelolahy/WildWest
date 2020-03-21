//
//  EquipTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 1/3/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Play any number of cards
 Now you may play cards to help yourself or hurt the other players, trying to
 eliminate them. You can only play cards during your turn (exception: Missed!
 and Beer, see below). You are not forced to play cards during this phase. You
 can play any number of cards; there are only three limitations:
 •     you can play only 1 BANG! card per turn;
 (this applies only to BANG! cards, not to cards with the symbol )
 •     you can have only 1 copy of any one card in play;
 (one card is a copy of another if they have the same name)
 •     you can have only 1 weapon in play.
 (when you play a new weapon, discard the one you have in play)
 Example. If you put a Barrel in play, you cannot play another one, since you
 would end up having two copies of the same card in front of you.
 
 Blue-bordered cards are played face up in front
 of you (exception: Jail). Blue cards in front of
 you are hence defined to be “in play”. The effect
 of these cards lasts until they are discarded or
 removed somehow (e.g. through the play of a Cat
 Balou), or a special event occurs (e.g. in the case of Dynamite). There is no
 limit on the cards you can have in front of you provided that they do not
 share the same name.
 
 Mustang
 When you have a Mustang horse in play the distance between
 other players and you is increased by 1. However, you still
 see the other players at the normal distance.
 Example. In the figure of the distance, if Ann (A) has a Mustang
 in play, Ben (B) and Flo (F) would see her at a distance of 2,
 Carl (C) and Emma (E) at a distance of 3, and Dan (D) at a
 distance of 4, while Ann would continue seeing all the other
 players at the normal distance.
 
 Scope
 When you have a Scope in play, you see all the other players
 at a distance decreased by 1. However, other players still
 see you at the normal distance. Distances less than 1 are
 considered to be 1.
 Example. In the figure of the distance, if Ann (A) has a Scope
 in play, she would see Ben (B) and Flo (F) at a distance of
 1, Carl (C) and Emma (E) at a distance of 1, Dan (D) at a
 distance of 2, while Ann would be seen by other players at a
 normal distance
 
 Draw!
 Some cards (Barrel, Jail, Dynamite) show little poker suits and values, then
 an equal sign and then their effects. The player using such a card must
 “draw!”, i.e. he has to flip over the top card of the deck,
 discard it, and look at the poker symbol in the lower left
 corner. If this flipped card shows a symbol (and value!) that
 matches, then the “draw!” was successful, and the effect of
 Bang-ENG.
 the card is resolved (the “draw!” card is always discarded without effect).
 Otherwise, nothing happens: bad luck! If a specific card value or range is
 specified on the card, then the “draw!” card must show a value within that
 range (including the pictured symbols), and the suit shown.
 The value sequence is: 2-3-4-5-6-7-8-9-10-J-Q-K-A.
 */
class EquipTests: XCTestCase {
    
    func test_EquipDescription() {
        // Given
        let sut = Equip(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_PutCardInPlay_IfEquipping() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let sut = Equip(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [.playerPutInPlay("p1", "c1")])
    }
    
    func test_DiscardPreviousGun_IfArmingNewGun() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.schofield))
            .playing(MockCardProtocol().identified(by: "c2").named(.volcanic))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let sut = Equip(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardInPlay("p1", "c2"),
            .playerPutInPlay("p1", "c1")])
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
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Equip], [
            Equip(actorId: "p1", cardId: "c1"),
            Equip(actorId: "p1", cardId: "c2"),
            Equip(actorId: "p1", cardId: "c3")
        ])
    }
    
    func test_CannotEquip_IfAlreadyPlayingCardWithTheSameName() {
        // Given
        let sut = EquipRule()
        let mockCard1 = MockCardProtocol().named(.mustang)
        let mockCard2 = MockCardProtocol().named(.mustang)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(mockCard2)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
    
    func test_CannotEquipJail() {
        // Given
        let sut = EquipRule()
        let mockCard = MockCardProtocol()
            .named(.jail)
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(actions)
    }
}
