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
        XCTAssertEqual(moves, [GameMove(name: .wellsFargo, actorId: "p1", cardId: "c1")])
    }
    
    func test_Pull3Cards_IfPlayingWellsFargo() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.wellsFargo))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .wellsFargo, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1")])
    }
}
