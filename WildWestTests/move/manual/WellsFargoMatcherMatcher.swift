//
//  WellsFargoMatcherMatcher.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 20/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class WellsFargoMatcherMatcher: XCTestCase {
    
    private let sut = WellsFargoMatcher()
    
    func test_CanPlayWellsFargo_IfYourTurnAndOwnCard() {
        // Given
        let mockCard = MockCardProtocol()
            .named(.wellsFargo)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .holding(mockCard)
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .playCard, actorId: "p1", cardId: "c1", cardName: .wellsFargo)])
    }
    
}
