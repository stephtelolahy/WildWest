//
//  DrawsFirstCardFromOtherPlayerTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class DrawsFirstCardFromOtherPlayerTests: XCTestCase {
    
    private let sut = StartTurnMatcher()
    
    func test_CanStartTurnDrawsFirstCardFromOtherPlayer_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnCanDrawFirstCardFromPlayer: true])
        let player2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c1"))
            .playing(MockCardProtocol().identified(by: "c2"))
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1, player2)
        
        // When
        let autoPlayMove = sut.autoPlayMove(matching: mockState)
        let validMoves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertNil(autoPlayMove)
        XCTAssertEqual(validMoves, [GameMove(name: .startTurn, actorId: "p1"),
                                    GameMove(name: .startTurnDrawFirstCardFromOtherPlayer, actorId: "p1",targetCard: TargetCard(ownerId: "p2", source: .randomHand)),
                                    GameMove(name: .startTurnDrawFirstCardFromOtherPlayer, actorId: "p1",targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))])
    }
    
    func test_CannotStartTurnDrawsFirstCardFromOtherPlayer_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnCanDrawFirstCardFromPlayer: true])
        let player2 = MockPlayerProtocol()
            .identified(by: "p2")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1, player2)
        
        // When
        let autoPlayMove = sut.autoPlayMove(matching: mockState)
        let validMoves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(autoPlayMove, GameMove(name: .startTurn, actorId: "p1"))
        XCTAssertNil(validMoves)
    }
    
    func test_PullFromOtherHand_IfExecutingStartTurnDrawsFirstCardFromOtherPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .holding(MockCardProtocol().identified(by: "c1"))
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .startTurnDrawFirstCardFromOtherPlayer, actorId: "p1", targetCard: TargetCard(ownerId: "p2", source: .randomHand))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromOtherHand("p1", "p2", "c1"),
                                 .playerPullFromDeck("p1"),])
    }
    
    func test_PullFromOtherInPlay_IfExecutingStartTurnDrawsFirstCardFromOtherPlayer() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .startTurnDrawFirstCardFromOtherPlayer, actorId: "p1", targetCard: TargetCard(ownerId: "p2", source: .inPlay("c2")))
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromOtherInPlay("p1", "p2", "c2"),
                                 .playerPullFromDeck("p1"),])
    }
    
}
