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
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByIndians() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2"]))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByDuel() {
        // Given
        let mockState = MockGameStateProtocol()
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"]))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_CanPass_IfChallengedByDynamiteExploded() {
        // Given
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .challenge(is: Challenge(name: .dynamiteExploded))
        
        // When
        let moves = sut.moves(matching: mockState)
        
        // Assert
        XCTAssertEqual(moves, [GameMove(name: .pass, actorId: "p1")])
    }
    
    func test_LooseHealth_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .allPlayers(are: mockPlayer1)
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"]))
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byPlayer("px"))),
                                 .playerSetHealth("p1", 3)])
    }
    
    func test_TriggerStartTurnChallenge_IfPassingOnDynamiteExploded() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p1")
            .allPlayers(are: mockPlayer1)
            .challenge(is: Challenge(name: .dynamiteExploded))
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .startTurn)),
                                 .playerSetDamage("p1", DamageEvent(damage: 3, source: .byDynamite)),
                                 .playerSetHealth("p1", 1)])
    }
    
    func test_RemoveActorFromBangChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .bang, targetIds: ["p1"]))
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byPlayer("px"))),
                                 .playerSetHealth("p1", 3)])
    }
    
    func test_RemoveActorFromGatlingChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .gatling, targetIds: ["p1", "p2", "p3"]))
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .gatling, targetIds: ["p2", "p3"])),
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byPlayer("px"))),
                                 .playerSetHealth("p1", 3)])
    }
    
    func test_RemoveActorFromIndiansChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "px")
            .challenge(is: Challenge(name: .indians, targetIds: ["p1", "p2", "p3"]))
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(Challenge(name: .indians, targetIds: ["p2", "p3"])),
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byPlayer("px"))),
                                 .playerSetHealth("p1", 3)])
    }
    
    func test_RemoveDuelChallenge_IfPassing() {
        // Given
        let mockPlayer1 = MockPlayerProtocol()
            .identified(by: "p1")
            .health(is: 4)
        let mockState = MockGameStateProtocol()
            .currentTurn(is: "p2")
            .challenge(is: Challenge(name: .duel, targetIds: ["p1", "p2"]))
            .allPlayers(are: mockPlayer1)
        let move = GameMove(name: .pass, actorId: "p1")
        
        // When
        let updates = sut.updates(onExecuting: move, in: mockState)
        
        // Assert
        XCTAssertEqual(updates, [.setChallenge(nil),
                                 .playerSetDamage("p1", DamageEvent(damage: 1, source: .byPlayer("p2"))),
                                 .playerSetHealth("p1", 3)])
    }
}
