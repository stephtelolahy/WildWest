//
//  StartGameTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class StartGameTests: XCTestCase {
    
    private let sut = StartGameMatcher()
    
    func test_ShouldStartGame_IfTurnIsEmpty() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: nil)
        
        // When
        let moves = sut.autoPlayMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .startGame)])
    }
    
    func test_SetTurn_IfStartingGame() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").role(is: .sheriff))
        let move = GameMove(name: .startGame)
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p1"),
                                 .setChallenge(.startTurn)])
    }
    
}
