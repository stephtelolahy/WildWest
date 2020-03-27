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
        let moves = sut.validMoves(matching: mockState)
        
        XCTAssertEqual(moves, [
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .duel, targetId: "p2"),
            GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .duel, targetId: "p3")
        ])
    }
}