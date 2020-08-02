//
//  DrawsFirstCardFromDiscardTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsFirstCardFromDiscardTests: XCTestCase {
    
    private let sut = StartTurnMatcher()
    
    func test_CanDrawFirstCardFromDiscard_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnCanDrawFirstCardFromDiscard: true])
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
            .topDiscardPile(is: MockCardProtocol().identified(by: "c1"))
        
        // When
        let autoPlayMove = sut.autoPlay(matching: mockState)
        let validMoves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(autoPlayMove)
        XCTAssertEqual(validMoves, [GameMove(name: .startTurn, actorId: "p1"),
                                    GameMove(name: .startTurnDrawFirstCardFromDiscard, actorId: "p1", cardId: "c1")])
    }
    
    func test_CannotDrawFirstCardFromDiscard_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnCanDrawFirstCardFromDiscard: true])
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
            .topDiscardPile(is: nil)
        
        // When
        let autoPlayMove = sut.autoPlay(matching: mockState)
        let validMoves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(autoPlayMove, GameMove(name: .startTurn, actorId: "p1"))
        XCTAssertNil(validMoves)
    }
    
    func test_PullFromDiscard_IfExecutingStartTurnDrawFirstCardFromDiscard() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .startTurnDrawFirstCardFromDiscard, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromDiscard("p1"),
                                 .playerPullFromDeck("p1")])
    }
}
