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
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1")])
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
    
    func test_PutCardInPlay_IfEquipping() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.dynamite))
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer)
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPutInPlay("p1", "c1")])
    }
}
