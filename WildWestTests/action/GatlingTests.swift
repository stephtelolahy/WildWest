//
//  GatlingTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class GatlingTests: XCTestCase {
    
    func test_DiscardCardAndSetChallengeToShootAllOtherPlayersRightDirection_IfPlayingGatling() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .withEnabledDefaultImplementation(GameStateProtocolStub())
            .players(are: mockPlayer4, mockPlayer1, mockPlayer2, mockPlayer3)
        let sut = Gatling(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).setChallenge(equal(to: .shoot(["p2", "p3", "p4"])))
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
            .currentTurn(is: 0)
            .players(are: mockPlayer)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Gatling], [Gatling(actorId: "p1", cardId: "c1")])
    }
}
