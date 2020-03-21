//
//  EndTurnExecutorTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EndTurnExecutorTests: XCTestCase {
    
    private let sut = EndTurnExecutor()
    
    func test_ChangeTurnToNextPlayer_IfAPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p2"),
                                 .setChallenge(.startTurn)])
    }
    
    func test_ChangeTurnToFirstPlayer_IfLastPlayerJustEndedTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p2")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p1"),
                                 .setChallenge(.startTurn)])
    }
    
    func test_DiscardExcessCards_IfEndingTurn() {
        // Given
        let mockPlayer1 = MockPlayerProtocol().identified(by: "p1")
        let mockPlayer2 = MockPlayerProtocol().identified(by: "p2")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .endTurn, actorId: "p1", discardedCardIds: ["c1", "c2"])
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2"),
                                 .setTurn("p2"),
                                 .setChallenge(.startTurn)])
    }
}
