//
//  EliminateMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 22/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest
import Cuckoo

class EliminateMatcherTests: XCTestCase {

    private let sut = EliminateMatcher()
    
    func test_ShouldEliminateActorAfterPass_IfHealthIsZero() {
        // Given
        let player1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .players(are: player1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .eliminate, actorId: "p1"))
    }
    
    func test_EliminatePlayer_IfEliminating() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .role(is: .renegade)
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
            .currentTurn(is: "p2")
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.eliminatePlayer("p1")])
    }
    
    func test_DiscardAllCards_IfPlayerEliminated() {
        // Given
        let mockCard1 = MockCardProtocol().identified(by: "c1")
        let mockCard2 = MockCardProtocol().identified(by: "c2")
        let mockCard3 = MockCardProtocol().identified(by: "c3")
        let mockCard4 = MockCardProtocol().identified(by: "c4")
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .role(is: .renegade)
            .holding(mockCard1, mockCard2)
            .playing(mockCard3, mockCard4)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
            .currentTurn(is: "p2")
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardHand("p1", "c2"),
                                 .playerDiscardInPlay("p1", "c3"),
                                 .playerDiscardInPlay("p1", "c4"),
                                 .eliminatePlayer("p1")])
    }
    
    func test_TriggerNextPlayerStartTurnChallenge_IfTurnPlayerIsEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .role(is: .outlaw)
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.eliminatePlayer("p1"),
                                 .setTurn("p2"),
                                 .setChallenge(.startTurn)])
    }
    
    func test_SetOutcomeIfGameIsOver() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .role(is: .sheriff)
        let mockState = MockGameStateProtocol()
            .players(are: mockPlayer1, mockPlayer2)
            .currentTurn(is: "p2")
        
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.eliminatePlayer("p1"),
                                 .setOutcome(.sheriffWin)])
    }
}
