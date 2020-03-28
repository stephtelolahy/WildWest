//
//  JailMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class JailMatcherTests: XCTestCase {

    private let sut = JailMatcher()
    
    func test_CanPlayJail_IfHoldingCardAndAgainsNonSheriffPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .outlaw)
            .noCardsInPlay()
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .jail, targetId: "p2")])
    }
    
    func test_CannotPlayJail_IfTargetPlayerIsSheriff() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_CannotPlayJail_IfTargetPlayerIsAlreadyInJail() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1").named(.jail))
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .deputy)
            .playing(MockCardProtocol().named(.jail))
        let mockState = MockGameStateProtocol()
            .challenge(is: nil)
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(moves)
    }
    
    func test_PutCardInPlayOfTargetPlayer_IfPlayingJail() {
        // Given
        let mockState = MockGameStateProtocol()
        let move = GameMove(name: .play, actorId: "p1", cardId: "c1", cardName: .jail, targetId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPutInPlayOfOther("p1", "p2", "c1")])
    }
}
