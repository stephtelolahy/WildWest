//
//  MissedTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 01/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

/**
 If you are hit by a BANG! you may
 immediately play a Missed! - even though
 it is not your turn! - to
 cancel the shot. If you do
 not, you lose one life point
 (discard a bullet). Discarded
 bullet go into a pile in the
 middle of the table. If you
 have no more bullets left,
 i.e. you lose your last life
 point, you are out of the
 game, unless you play
 immediately a Beer (see
 next paragraph). You can only cancel shots
 aimed at you. The BANG! card is discarded,
 even when cancelled
 */
class MissedTests: XCTestCase {
    
    func test_MissedDescription() {
        // Given
        let sut = Missed(actorId: "p1", cardId: "c1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 plays c1")
    }
    
    func test_DiscardCardAndRemoveChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol().challenge(is: .shoot(["p1"], .bang, "px"))
        let sut = Missed(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(nil)
        ])
    }
    
    func test_DiscardCardAndRemoveActorFromChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, "px"))
        let sut = Missed(actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .setChallenge(.shoot(["p2", "p3"], .gatling, "px"))
        ])
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
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2"], .gatling, "px"))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Missed], [Missed(actorId: "p1", cardId: "c1")])
    }
}
