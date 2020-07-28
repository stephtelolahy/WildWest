//
//  DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 17/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsAnotherCardIfSecondDrawIsRedSuitMatcherTests: XCTestCase {
    
    private let sut = StartTurnMatcher()
    
    func test_ShouldStartTurnDrawAnotherCardIfRedSuit_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnDrawsAnotherCardIfRedSuit: true])
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
        
        // When
        let autoPlayMove = sut.autoPlayMove(matching: mockState)
        let validMoves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(autoPlayMove, GameMove(name: .startTurnDrawAnotherCardIfRedSuit, actorId: "p1"))
        XCTAssertNil(validMoves)
    }
    
    func test_DrawsAnotherCardIfSecondDrawIsRedSuit_IfHavingAbility() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        let mockCard2 = MockCardProtocol().identified(by: "c2").suit(is: .hearts)
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .deckCards(are: mockCard1, mockCard2)
        let move = GameMove(name: .startTurnDrawAnotherCardIfRedSuit, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerRevealHandCard("p1", "c2"),
                                 .playerPullFromDeck("p1")])
    }
    
    func test_DoNotDrawsAnotherCardIfSecondDrawIsNotRedSuit_IfHavingAbility() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1").suit(is: .clubs)
        let mockCard2 = MockCardProtocol().identified(by: "c2").suit(is: .spades)
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
            .deckCards(are: mockCard1, mockCard2)
        let move = GameMove(name: .startTurnDrawAnotherCardIfRedSuit, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerRevealHandCard("p1", "c2")])
    }
    
}
