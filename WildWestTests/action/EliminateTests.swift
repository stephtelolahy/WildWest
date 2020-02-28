//
//  EliminateTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 28/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class EliminateTests: XCTestCase {
    
    func test_Eliminate_Description() {
        // Given
        let sut = Eliminate(actorId: "p1")
        
        // When
        // Assert
        XCTAssertEqual(sut.description, "p1 is eliminated")
    }

    func test_EliminatePlayer_IfEliminating() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
        let sut = Eliminate(actorId: "p1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .eliminatePlayer("p1")
        ])
    }
    
    func test_TriggerNextPlayerStartTurnChallenge_IfTurnPlayerIsEliminated() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: MockPlayerProtocol().identified(by: "p1"),
                     MockPlayerProtocol().identified(by: "p2"))
        let sut = Eliminate(actorId: "p1")
        
        // When
        let updates = sut.execute(in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .eliminatePlayer("p1"),
            .setTurn("p2"),
            .setChallenge(.startTurn)
        ])
    }
}

class EliminateRuleTests: XCTestCase {
    
    func test_ShouldEliminateActor_IfHealthIsZero() {
        // Given
        let sut = EliminateRule()
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .players(are: player1)
        
        // When
        let actions = sut.match(with: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Eliminate], [Eliminate(actorId: "p1")])
    }
}
