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
            .challenge(is: Challenge(name: .gatling, actorId: "px", targetIds: ["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .missed)])
    }
    
    func test_DiscardCardAndRemoveShootChallenge_IfPlayingMissed() {
        // Given
        let mockState = MockGameStateProtocol().challenge(is: Challenge(name: .bang, actorId: "px", targetIds: ["p1"]))
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
            .challenge(is: Challenge(name: .gatling, actorId: "px", targetIds: ["p1", "p2", "p3"]))
        let move = GameMove(name: .discard, actorId: "p1", cardId: "c1", cardName: .missed)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .setChallenge(Challenge(name: .gatling, actorId: "px", targetIds: ["p2", "p3"]))])
    }
}
