//
//  GatlingTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Gatling
 The Gatling shoots “a BANG!” to “all the other players”,
 regardless of the distance. Even though the Gatling shoots
 a BANG! to all the other players, it is not considered a
 BANG! card. During your turn you can play any number of
 Gatling, but only one BANG! card.
 */
class GatlingTests: XCTestCase {
    
    func test_GatlingDescription() {
        // Given
        let sut = Gatling(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_DiscardCardAndSetChallengeToShootAllOtherPlayersRightDirection_IfPlayingGatling() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2, mockPlayer3, mockPlayer4)
        let sut = Gatling(actorId: "p2", cardId: "c2")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p2", "c2"),
            .setChallenge(.shoot(["p3", "p4", "p1"], .gatling, "p2"))
        ])
    }
}

class GatlingRuleTests: XCTestCase {
    
    func test_CanPlayGatling_IfYourTurnAndOwnCard() {
        // Given
        let sut = GatlingRule()
        let mockCard = MockCardProtocol()
            .named(.gatling)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Gatling], [Gatling(actorId: "p1", cardId: "c1")])    }
}
