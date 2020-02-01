//
//  MissedTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class MissedTests: XCTestCase {
    
    func test_DiscardMissedCardAndRemoveChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol().withEnabledDefaultImplementation(GameStateProtocolStub())
        let sut = Missed(actorId: "p1", cardId: "c1")
        
        // When
        sut.execute(in: mockState)
        
        // Assert
        verify(mockState).discardHand(playerId: "p1", cardId: "c1")
        verify(mockState).setChallenge(isNil())
    }
}

class MissedRuleTests: XCTestCase {
    
    func test_CanPlayMissed_IfIsTargetOfBangAndHoldingMissedCard() {
        // Given
        let sut = MissedRule()
        let mockCard = MockCardProtocol()
            .named(.missed)
            .identified(by: "c1")
        let mockPlayer1 = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .challenge(is: .bang(actorId: "p2", targetId: "p1"))
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Missed], [Missed(actorId: "p1", cardId: "c1")])
    }
}
