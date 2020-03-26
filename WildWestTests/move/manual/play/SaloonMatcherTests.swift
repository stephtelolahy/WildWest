//
//  SaloonMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 3/17/20.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class SaloonMatcherTests: XCTestCase {
    
    private let sut = SaloonMatcher()
    
    func test_CanPlaySaloon_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.saloon)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 2)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .saloon)])
    }
    
    func test_CannotPlaySaloon_IfAllPlayersFullLife() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.saloon)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
            .health(is: 4)
            .maxHealth(is: 4)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
}
