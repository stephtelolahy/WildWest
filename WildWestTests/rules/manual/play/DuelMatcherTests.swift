//
//  DuelMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DuelMatcherTests: XCTestCase {
    
    private let sut = DuelMatcher()
    
    func test_CanPlayDuel_IfYourTurnAndOwnCard() {
        // Given
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
        let moves = sut.moves(matching: mockState)
        
        XCTAssertEqual(moves, [
            GameMove(name: .duel, actorId: "p1", cardId: "c1", targetId: "p2"),
            GameMove(name: .duel, actorId: "p1", cardId: "c1", targetId: "p3")
        ])
    }
    
    func test_TriggerDuelChallenge_IfPlayingDuel() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().named(.duel).identified(by: "c1"))
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .duel, actorId: "p1", cardId: "c1", targetId: "p2")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .duel, targetIds: ["p2", "p1"], damage: 1)),
                                 .playerDiscardHand("p1", "c1")])
    }
}
