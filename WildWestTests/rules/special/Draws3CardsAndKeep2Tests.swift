//
//  Draws3CardsAndKeep2Tests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 29/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class Draws3CardsAndKeep2Tests: XCTestCase {

    private let sut = StartTurnMatcher()
    
    func test_ShouldStartTurnDraw3CardsAndKeep2_IfHavingAbility() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .noCardsInPlay()
            .abilities(are: [.onStartTurnDraws3CardsAndKeep2: true])
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .startTurn))
            .players(are: player1)
            .deckCards(are: MockCardProtocol().identified(by: "c1"),
                       MockCardProtocol().identified(by: "c2"),
                       MockCardProtocol().identified(by: "c3"))
        
        // When
        let autoPlayMove = sut.autoPlay(matching: mockState)
        let validMoves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertNil(autoPlayMove)
        XCTAssertEqual(validMoves, [GameMove(name: .startTurnDraw3CardsAndKeep2, actorId: "p1", discardIds: ["c1"]),
                                    GameMove(name: .startTurnDraw3CardsAndKeep2, actorId: "p1", discardIds: ["c2"]),
                                    GameMove(name: .startTurnDraw3CardsAndKeep2, actorId: "p1", discardIds: ["c3"])])
    }
    
    func test_StartTurnDraws3CardsAndKeep2_IfHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1)
        let move = GameMove(name: .startTurnDraw3CardsAndKeep2, actorId: "p1", discardIds: ["c1"])
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetBangsPlayed("p1", 0),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerPullFromDeck("p1"),
                                 .playerDiscardTopDeck("p1", "c1")])
    }
}
