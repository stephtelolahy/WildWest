//
//  IndiansTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 Indians!
 Each player, excluding the one who played this card, may
 discard a BANG! card, or lose one life point. Neither Missed!
 nor Barrel have effect in this case.
 */
class IndiansTests: XCTestCase {
    
    func test_IndiansDescription() {
        // Given
        let sut = Indians(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_DiscardCardAndSetChallengeToIndiansAllOtherPlayersRightDirection_IfPlayingIndians() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer4, mockPlayer1, mockPlayer2, mockPlayer3)
        let sut = Indians(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.indians(["p2", "p3", "p4"]))
        ])
    }
}

class IndiansRuleTests: XCTestCase {
    
    func test_CanPlayIndians_IfYourTurnAndOwnCard() {
        // Given
        let sut = IndiansRule()
        let mockCard = MockCardProtocol()
            .named(.indians)
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
        XCTAssertEqual(actions as? [Indians], [Indians(actorId: "p1", cardId: "c1")])
    }
}
