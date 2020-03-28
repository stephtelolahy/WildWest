//
//  DiscardMissedMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DiscardMissedMatcherTests: XCTestCase {
    
    private let sut = DiscardMissedMatcher()
    
    func test_CanPlayMissed_IfIsTargetOfBangAndHoldingMissedCard() {
        // Given
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
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .missed)])
    }
    
    func test_DiscardCardAndRemoveShootChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol().challenge(is: .shoot(["p1"], .bang, "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .missed)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(nil)])
    }
    
    func test_DiscardCardAndRemoveActorFromShootChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: .shoot(["p1", "p2", "p3"], .gatling, "px"))
        let move = GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .missed)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(.shoot(["p2", "p3"], .gatling, "px"))])
    }
}
