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
            .allPlayers(are: player1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let effect = sut.effect(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(effect, GameMove(name: .eliminate, actorId: "p1"))
    }
    
    func test_DoNothing_IfPlayerEliminatedWithoutCards() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .withDefault()
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
            .currentTurn(is: "p2")
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [])
    }
    
    func test_DiscardAllCards_IfPlayerEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1"))
            .playing(MockCardProtocol().identified(by: "c2"))
            .health(is: 0)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1)
            .currentTurn(is: "p2")
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerDiscardHand("p1", "c1"),
                                 .playerDiscardInPlay("p1", "c2")])
    }
    
    func test_AnotherPlayerTakesAllCards_IfPlayerEliminatedAndHavingAbility() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .holding(MockCardProtocol().identified(by: "c1"))
            .playing(MockCardProtocol().identified(by: "c2"))
            .health(is: 0)
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .abilities(are: [.takesAllCardsFromEliminatedPlayers: true])
            .health(is: 1)
        let mockState = MockGameStateProtocol()
            .allPlayers(are: mockPlayer1, mockPlayer2)
            .currentTurn(is: "p2")
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerPullFromOtherHand("p2", "p1", "c1"),
                                 .playerPullFromOtherInPlay("p2", "p1", "c2")])
    }
    
    func test_TriggerNextPlayerStartTurnChallenge_IfTurnPlayerIsEliminated() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .withDefault()
        let mockPlayer2 = MockPlayerProtocol()
            .identified(by: "p2")
            .health(is: 2)
            .withDefault()
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1, mockPlayer2)
        let move = GameMove(name: .eliminate, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setTurn("p2"),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
}
