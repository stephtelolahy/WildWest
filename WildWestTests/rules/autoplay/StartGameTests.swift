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
            .players(are: MockPlayerProtocol().role(is: .sheriff).identified(by: "p1"))
            .currentTurn(is: nil)
        
        // When
        let move = sut.autoPlayMove(matching: mockState)
        
        // Assert
        XCTAssertEqual(move, GameMove(name: .startGame, actorId: "p1"))
    }
    
    func test_SetTurn_IfStartingGame() {
        // Given
        let mockState = MockGameStateProtocol()
            .players(are: MockPlayerProtocol().identified(by: "p1").role(is: .sheriff))
        let move = GameMove(name: .startGame, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p1"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
}
