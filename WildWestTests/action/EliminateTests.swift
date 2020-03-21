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
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .withEnabledDefaultImplementation(PlayerProtocolStub())
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer,
                     MockPlayerProtocol().identified(by: "p2"))
            .currentTurn(is: "p2")
        let sut = Eliminate(actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .eliminatePlayer("p1")
        ])
    }
    
    func test_DiscardAllCards_IfPlayerEliminated() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1")
        let mockCard2 = MockCardProtocol().identified(by: "c2")
        let mockCard3 = MockCardProtocol().identified(by: "c3")
        let mockCard4 = MockCardProtocol().identified(by: "c4")
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(mockCard1, mockCard2)
            .playing(mockCard3, mockCard4)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer, MockPlayerProtocol().identified(by: "p2"))
            .currentTurn(is: "p2")
        let sut = Eliminate(actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates as? [GameUpdate], [
            .playerDiscardHand("p1", "c1"),
            .playerDiscardHand("p1", "c2"),
            .playerDiscardInPlay("p1", "c3"),
            .playerDiscardInPlay("p1", "c4"),
            .eliminatePlayer("p1")
        ])
    }
    
    func test_TriggerNextPlayerStartTurnChallenge_IfTurnPlayerIsEliminated() {
        // Given
        let mockPlayer = MockPlayerProtocol()
            .identified(by: "p1")
            .withEnabledDefaultImplementation(PlayerProtocolStub())
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer,
                     MockPlayerProtocol().identified(by: "p2"))
        let sut = Eliminate(actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
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
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(actions as? [Eliminate], [Eliminate(actorId: "p1")])
    }
}
