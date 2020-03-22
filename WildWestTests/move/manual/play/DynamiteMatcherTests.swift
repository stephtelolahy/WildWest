//
//  DynamiteMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DynamiteMatcherTests: XCTestCase {

    private let sut = DynamiteMatcher()
    
    func test_CanPlayDynamite_IfYourTurnAndOwnCard() {
        // Given
        let mockCard1 = MockCardProtocol()
            .named(.dynamite)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1)
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .dynamite)])
    }
    
    func test_CannotPlayDynamite_IfAlreadyPlayingDynamite() {
        // Given
        let mockCard1 = MockCardProtocol()
            .named(.dynamite)
            .identified(by: "c1")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1)
            .playing(MockCardProtocol().named(.dynamite))
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
