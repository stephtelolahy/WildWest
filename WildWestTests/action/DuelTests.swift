//
//  DuelTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Duel
 With this card you can challenge any other
 player (staring him in the eyes!), regardless
 of the distance. The challenged player may discard a BANG!
 card (even though it is not his turn!). If he does, you may
 discard a BANG! card, and so on: the first player failing to
 discard a BANG! card loses one life point, and the duel is
 over. You cannot play Missed! or use the Barrel during a
 duel. The Duel is not a BANG! card. BANG! cards discarded
 during a Duel are not accounted towards the “one BANG!
 card” limitation.
 */
class DuelTests: XCTestCase {
    
    func test_DuelDescription() {
        // Given
        let sut = Duel(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1 against p2")
    }
    
    func test_TriggerDuelChallenge_IfPlayingDuel() {
        // Given
        let mockState = MockGameStateProtocol()
        let sut = Duel(actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.duel(["p2", "p1"], .byPlayer("p1")))
        ])
    }
}

class DuelRuleTests: XCTestCase {
    
    func test_CanPlayDuel_IfYourTurnAndOwnCard() {
        // Given
        let sut = DuelRule()
        let mockCard = MockCardProtocol()
            .named(.duel)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3)
        
        // When
        let actions = sut.match(with: mockState)
        
        XCTAssertEqual(actions as? [Duel], [
            Duel(actorId: "p1", cardId: "c1", targetId: "p2"),
            Duel(actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
}
