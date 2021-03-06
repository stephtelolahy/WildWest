//
//  IndiansMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class IndiansMatcherTests: XCTestCase {
    
    private let sut = IndiansMatcher()
    
    func test_CanPlayIndians_IfYourTurnAndOwnCard() {
        // Given
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
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .indians, actorId: "p1", cardId: "c1")])
    }
    
    func test_DiscardCardAndSetChallengeToIndiansAllOtherPlayersRightDirection_IfPlayingIndians() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
            .holding(MockCardProtocol().named(.indians).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockPlayer3 = MockPlayerProtocol().identified(by: "p3")
        let mockPlayer4 = MockPlayerProtocol().identified(by: "p4")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer4, mockPlayer1, mockPlayer2, mockPlayer3)
        let move = GameMove(name: .indians, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .indians, targetIds: ["p2", "p3", "p4"], damage: 1)),
                                 .playerDiscardHand("p1", "c1")])
    }
}
