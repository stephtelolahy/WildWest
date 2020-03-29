//
//  PassMatcherTests.swift
//  WildWestTests
//
//  Created by Hugues Stephano Telolahy on 21/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import XCTest

class PassMatcherTests: XCTestCase {
    
    private let sut = PassMatcher()
    
    func test_CanPass_IfChallengedByShoot() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2"]))
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByIndians() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2"]))
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByDuel() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"]))
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded))
        
        // When
        let moves = sut.validMoves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_LooseHealth_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .players(are: mockPlayer1)
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"]))
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(nil)])
    }
    
    func test_TriggerStartTurnChallenge_IfPassingOnDynamiteExploded() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .players(are: mockPlayer1)
            .challenge(is: Challenge(name: .dynamiteExploded))
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 3, .byDynamite),
                                 .setChallenge(Challenge(name: .startTurn))])
    }
    
    func test_RemoveActorFromShootChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(Challenge(name: .gatling, targetIds: ["p2", "p3"]))])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2", "p3"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("px")),
                                 .setChallenge(Challenge(name: .indians, targetIds: ["p2", "p3"]))])
    }
    
    func test_RemoveDuelChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"]))
            .players(are: mockPlayer1, MockPlayerProtocol(), MockPlayerProtocol())
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.execute(move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.playerLooseHealth("p1", 1, .byPlayer("p2")),
                                 .setChallenge(nil)])
    }
}
